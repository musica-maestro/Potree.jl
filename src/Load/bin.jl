"""
    function decodePoint(point::Int32, scale::Float32, boundingBoxMin::Float32) -> Float32

decodes a point of a bin file (https://github.com/PropellerAero/potree-propeller-private/blob/master/docs/file_format.md )
"""
function decodePoint(point::Int32, scale::Float64, boundingBoxMin::Float64)::Float64
	return (point * scale) + boundingBoxMin
end


"""
binToPointsUgly(fname::String) -> nothing

First version of decoder doesn't return nothing. 
It just shows the decoded points and Binary code for rgba
"""
function binToPointsUgly(fname::String)
	read(fname, data)

	#divido in pacchetti di 4 * 4 byte
	rawdata = reshape(data, (16, div(length(data), 16)))

	for i in 1:size(rawdata,2)
		x = parse(Int32, bitstring(UInt8(rawdata[4,i]))*bitstring(UInt8(rawdata[3,i]))*bitstring(UInt8(rawdata[2,i]))*bitstring(UInt8(rawdata[1,i])); base=2)
		y = parse(Int32, bitstring(UInt8(rawdata[8,i]))*bitstring(UInt8(rawdata[7,i]))*bitstring(UInt8(rawdata[6,i]))*bitstring(UInt8(rawdata[5,i])); base=2)
		z = parse(Int32, bitstring(UInt8(rawdata[12,i]))*bitstring(UInt8(rawdata[11,i]))*bitstring(UInt8(rawdata[10,i]))*bitstring(UInt8(rawdata[9,i])); base=2)
		r = parse(Int32, bitstring(UInt8(rawdata[13,i])))
		g = parse(Int32, bitstring(UInt8(rawdata[14,i])))
		b = parse(Int32, bitstring(UInt8(rawdata[15,i])))
		a = parse(Int32, bitstring(UInt8(rawdata[16,i])))
		@show decodeX(x), decodeY(y), decodeZ(z)
		@show r,g,b,a
	end
end

"""
bin2points(fname::String) -> Array{Float64,2}(undef, 3, 0)

Returns every point of the passed bin file.
"""
function bin2points(fname::String, cloud_metadata::CloudMetadata)::Array{Float64,2}
	data = read(fname)
	scale = cloud_metadata.scale
	bb = cloud_metadata.boundingBox

	#divido in pacchetti di 4 * 4 byte
	rawdata = reshape(data, (16, div(length(data), 16)))

	allPoints = Array{Float64,2}(undef, 3, 0)



	for i in 1:size(rawdata,2)
		x = parse(Int32, bitstring(UInt8(rawdata[4,i]))*bitstring(UInt8(rawdata[3,i]))*bitstring(UInt8(rawdata[2,i]))*bitstring(UInt8(rawdata[1,i])); base=2)
		y = parse(Int32, bitstring(UInt8(rawdata[8,i]))*bitstring(UInt8(rawdata[7,i]))*bitstring(UInt8(rawdata[6,i]))*bitstring(UInt8(rawdata[5,i])); base=2)
		z = parse(Int32, bitstring(UInt8(rawdata[12,i]))*bitstring(UInt8(rawdata[11,i]))*bitstring(UInt8(rawdata[10,i]))*bitstring(UInt8(rawdata[9,i])); base=2)

		allPoints = hcat(allPoints, vcat(decodePoint(x, scale, bb.x_min),decodePoint(y, scale, bb.y_min),decodePoint(z, scale, bb.z_min)))

	end
	return allPoints
end




"""
bin2rgb(fname::String) -> {LasIO.N0f16,2}(undef, 3, 0)

(BUGGED RETURN) TODO: parse rgba to LasIO.N0f16
"Should" return rgb(a) values of every point of the bin file.
"""
function bin2rgb(fname::String)
	data = read(fname)

	allRGB = Array{LasIO.N0f16,2}(undef, 3, 0)

	#divido in pacchetti di 4 * 4 byte
	rawdata = reshape(data, (16, div(length(data), 16)))

	for i in 1:size(rawdata,2)
		r = parse(Int32, bitstring(UInt8(rawdata[13,i])))
		g = parse(Int32, bitstring(UInt8(rawdata[14,i])))
		b = parse(Int32, bitstring(UInt8(rawdata[15,i])))
		a = parse(Int32, bitstring(UInt8(rawdata[16,i])))
		allRGB = hcat(allRGB, vcat(r,g,b))
	end
	return allRGB
end

"""
bin2pointcloud(source::String) ->  Array{Float64,2}(undef, 3, 0)

TODO: check bin2rgb + create the PC
Will return a PointCloud
"""
function bin2pointcloud(source::String)::Array{Float64,2}
	
	cloud_metadata = Potree.CloudMetadata(source)
	trie = Potree.potree2trie(source)
	all_files = Potree.get_all_values(trie)

	Vtot = Array{Float64,2}(undef, 3, 0)
	rgbtot = Array{LasIO.N0f16,2}(undef, 3, 0)
	
	l = Threads.ReentrantLock()

	Threads.@threads for fname in all_files
		partialV = bin2points(fname, cloud_metadata)
		partialRGB = bin2rgb(fname)
		Threads.lock(l)
		Vtot = hcat(Vtot, partialV)
		rgbtot = hcat(rgbtot, partialRGB)
		Threads.unlock(l)
	end
	return Vtot
end

"""
bin2pointcloudNoMultithreading(source::String) ->  Array{Float64,2}(undef, 3, 0)

TODO: check bin2rgb + create the PC
Will return a PointCloud
"""
function bin2pointcloudNoMultithreading(source::String)::Array{Float64,2}
	
	cloud_metadata = Potree.CloudMetadata(source)
	trie = Potree.potree2trie(source)
	all_files = Potree.get_all_values(trie)

	Vtot = Array{Float64,2}(undef, 3, 0)
	rgbtot = Array{LasIO.N0f16,2}(undef, 3, 0)
	
	for fname in all_files
		partialV = bin2points(fname, cloud_metadata)
		partialRGB = bin2rgb(fname)
		Vtot = hcat(Vtot, partialV)
		rgbtot = hcat(rgbtot, partialRGB)
	end
	return Vtot
end




"""
bin2parsing(fname::String) -> Array{Float64,2}(undef, 3, 0)

Returns every point of the passed bin file.
"""
function binParsing(fname::String, cloud_metadata::CloudMetadata)
	data = read(fname)
	scale = cloud_metadata.scale
	bb = cloud_metadata.boundingBox

	allPoints = Array{Float64,2}(undef, 3, 0)
	allRGB = Array{LasIO.N0f16,2}(undef, 3, 0)

	io = open(fname, "r");

	while !eof(io)
		x = Int32(read(io, UInt32))
		y = Int32(read(io, UInt32))
		z = Int32(read(io, UInt32))
		r = read(io, UInt8)
		g = read(io, UInt8)
		b = read(io, UInt8)
		a = read(io, UInt8)
		allPoints = hcat(allPoints, vcat(decodePoint(x, scale, bb.x_min),decodePoint(y, scale, bb.y_min),decodePoint(z, scale, bb.z_min)))
		# allRGB = hcat(allRGB, vcat(r,g,b))
	end

	# return allPoints, allRGB
	return allPoints
end

function bin2pointcloudNEW(source::String)::PointCloud
	
	cloud_metadata = Potree.CloudMetadata(source)
	trie = Potree.potree2trie(source)
	all_files = Potree.get_all_values(trie)

	Vtot = Array{Float64,2}(undef, 3, 0)
	rgbtot = Array{LasIO.N0f16,2}(undef, 3, 0)
	
	for fname in all_files
		# partialV, partialRGB = binParsing(fname, cloud_metadata)
		partialV = binParsing(fname, cloud_metadata)
		Vtot = hcat(Vtot, partialV)
		# rgbtot = hcat(rgbtot, partialRGB)
	end
	return PointCloud(Vtot)
end