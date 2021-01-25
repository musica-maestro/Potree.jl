using Potree
using DataStructures

function decode(x::Int32, xyz::String)::Float32
	
	potree = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory
	metadata = CloudMetadata(potree)
	boundingBox = metadata.boundingBox
	scale = metadata.scale
	
	if(xyz=="x")
		return x * 0.001 + boundingBox.x_min
	elseif(xyz=="y")
		return x * 0.001 + boundingBox.y_min
	else
		return x * 0.001 + boundingBox.z_min
	end
end

# sources
potree = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory
hrcfile = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)/data/r/r.hrc" # hrc

# uso nodi piccoli
binfile = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)/data/r/r606.bin"
lasfile = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)/data/r/r606.las"


metadata = CloudMetadata(potree)
boundingBox = metadata.boundingBox
scale = metadata.scale
totalPoints = metadata.points
points = Potree.las2larpoints(lasfile)
pointsSFile = size(points)  #187

println(pointsSFile)

println( points[1])
println( points[2])
println( points[3])

data = read(binfile)


#divido in pacchetti di 4 * 4 byte e la lunghezza totale in 
treehrc = reshape(data, (16, div(length(data), 16)))

println(size(treehrc))


println("SHOWWWWWWWWWWWWWWWTIME")

for i in 1:size(treehrc,2)
	x = parse(Int32, bitstring(UInt8(treehrc[4,i]))*bitstring(UInt8(treehrc[3,i]))*bitstring(UInt8(treehrc[2,i]))*bitstring(UInt8(treehrc[1,i])); base=2)
	y = parse(Int32, bitstring(UInt8(treehrc[8,i]))*bitstring(UInt8(treehrc[7,i]))*bitstring(UInt8(treehrc[6,i]))*bitstring(UInt8(treehrc[5,i])); base=2)
	z = parse(Int32, bitstring(UInt8(treehrc[12,i]))*bitstring(UInt8(treehrc[11,i]))*bitstring(UInt8(treehrc[10,i]))*bitstring(UInt8(treehrc[9,i])); base=2)
	r = parse(Int32, bitstring(UInt8(treehrc[13,i])))
	g = parse(Int32, bitstring(UInt8(treehrc[14,i])))
	b = parse(Int32, bitstring(UInt8(treehrc[15,i])))
	a = parse(Int32, bitstring(UInt8(treehrc[16,i])))
	@show decode(x, "x"), decode(y, "y"), decode(z, "z")
	@show r,g,b,a
end

# fname2 = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)/data/r/r0.bin"

# io = open(fname2, "r")

# n = Int32
# data2 = Array{Int32, 1}(undef, 70) # number of files = 70 
# println(position(io))
# n = read(io, 1)
# println(position(io))
# data2 = read(io, 4)
# println(position(io))
# println(reinterpret(Int8, n))

# for n in data2
#     println(reinterpret(Int8, n))
# end