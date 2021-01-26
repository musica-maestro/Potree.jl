"""
    function decodePoint(point::Int32, scale::Float32, boundingBoxMin::Float32) -> Float32

decodes a point of a bin file (https://github.com/PropellerAero/potree-propeller-private/blob/master/docs/file_format.md )
"""
function decodePoint(point::Int32, scale::Float64, boundingBoxMin::Float64)::Float64
	return (point * scale) + boundingBoxMin
end


"""

First version of decoder
"""
function binToPointsUgly(fname::String)
	data = read(fname)

	#divido in pacchetti di 4 * 4 byte
	treehrc = reshape(data, (16, div(length(data), 16)))

	for i in 1:size(treehrc,2)
		x = parse(Int32, bitstring(UInt8(treehrc[4,i]))*bitstring(UInt8(treehrc[3,i]))*bitstring(UInt8(treehrc[2,i]))*bitstring(UInt8(treehrc[1,i])); base=2)
		y = parse(Int32, bitstring(UInt8(treehrc[8,i]))*bitstring(UInt8(treehrc[7,i]))*bitstring(UInt8(treehrc[6,i]))*bitstring(UInt8(treehrc[5,i])); base=2)
		z = parse(Int32, bitstring(UInt8(treehrc[12,i]))*bitstring(UInt8(treehrc[11,i]))*bitstring(UInt8(treehrc[10,i]))*bitstring(UInt8(treehrc[9,i])); base=2)
		r = parse(Int32, bitstring(UInt8(treehrc[13,i])))
		g = parse(Int32, bitstring(UInt8(treehrc[14,i])))
		b = parse(Int32, bitstring(UInt8(treehrc[15,i])))
		a = parse(Int32, bitstring(UInt8(treehrc[16,i])))
		@show decodeX(x), decodeY(y), decodeZ(z)
		@show r,g,b,a
	end
end

function bin2points(fname::String, cloud_metadata::CloudMetadata)
	data = read(fname)

	scale = cloud_metadata.scale
	bb = cloud_metadata.boundingBox

	#divido in pacchetti di 4 * 4 byte
	treehrc = reshape(data, (16, div(length(data), 16)))

	allPoints = Array{Float64,2}(undef, 3, 0)

	for i in 1:size(treehrc,2)
		x = parse(Int32, bitstring(UInt8(treehrc[4,i]))*bitstring(UInt8(treehrc[3,i]))*bitstring(UInt8(treehrc[2,i]))*bitstring(UInt8(treehrc[1,i])); base=2)
		y = parse(Int32, bitstring(UInt8(treehrc[8,i]))*bitstring(UInt8(treehrc[7,i]))*bitstring(UInt8(treehrc[6,i]))*bitstring(UInt8(treehrc[5,i])); base=2)
		z = parse(Int32, bitstring(UInt8(treehrc[12,i]))*bitstring(UInt8(treehrc[11,i]))*bitstring(UInt8(treehrc[10,i]))*bitstring(UInt8(treehrc[9,i])); base=2)
		
		allPoints = hcat(allPoints, vcat(decodePoint(x, scale, bb.x_min),decodePoint(y, scale, bb.y_min),decodePoint(z, scale, bb.z_min)))
	end
	return allPoints
end


function bin2rgb(fname::String)
	data = read(fname)

	allRGB = Array{LasIO.N0f16,2}(undef, 3, 0)

	#divido in pacchetti di 4 * 4 byte
	treehrc = reshape(data, (16, div(length(data), 16)))

	for i in 1:size(treehrc,2)
		r = parse(Int32, bitstring(UInt8(treehrc[13,i])))
		g = parse(Int32, bitstring(UInt8(treehrc[14,i])))
		b = parse(Int32, bitstring(UInt8(treehrc[15,i])))
		a = parse(Int32, bitstring(UInt8(treehrc[16,i])))
		allRGB = hcat(allPoints, vcat(r,g,b))
	end
	return allRGB
end

"""
bin2pointcloud
"""
function bin2pointcloud(source::String)
	
	cloud_metadata = Potree.CloudMetadata(source)
	trie = Potree.potree2trie(source)
	all_files = Potree.get_all_values(trie)

	Vtot = Array{Float64,2}(undef, 3, 0)
	rgbtot = Array{LasIO.N0f16,2}(undef, 3, 0)

	for fname in all_files
		partialV = bin2points(fname, cloud_metadata)
		#partialRGB = bin2rgbs(fname)
		Vtot = hcat(Vtot, partialV)
		#rgbtot = hcat(rgbtot, partialRGB)
	end
	return Vtot
end