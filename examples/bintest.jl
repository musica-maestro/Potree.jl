using Potree
using DataStructures

function decodeX(x::Int32)::Float32
	
	potree = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory
	metadata = CloudMetadata(potree)
	boundingBox = metadata.boundingBox
	scale = metadata.scale
	
	return (x * scale) + boundingBox.x_min
end

function decodeY(x::Int32)::Float32
	
	potree = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory
	metadata = CloudMetadata(potree)
	boundingBox = metadata.boundingBox
	scale = metadata.scale
	
	return (x * scale) + boundingBox.y_min
end

function decodeZ(x::Int32)::Float32
	
	potree = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory
	metadata = CloudMetadata(potree)
	boundingBox = metadata.boundingBox
	scale = metadata.scale
	
	return (x * scale) + boundingBox.z_min
end

function binToPoints(fname::String)
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


# sources
potree = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory
hrcfile = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)/data/r/r.hrc" # hrc

# uso nodi piccoli
binfile = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)/data/r/r606.bin"
lasfile = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)/data/r/r606.las"


metadata = CloudMetadata(potree)
totalPoints = metadata.points
points = Potree.las2larpoints(lasfile)
rgb = Potree.las2color(lasfile)


binToPoints(binfile)

println(points[length(points)-2])
println(points[length(points)-1])
println(points[length(points)])
println(rgb[length(rgb)][1])