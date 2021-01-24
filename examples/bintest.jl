# struct BinPC
#     positionCartesian::Array{Float32, 3}
#     colorPacked::Array{Int8, 4}
#     #rgbPacked::Array{Int8, 3}
#     #normalFloats::Array{Float32, 3}
#     intensity::UInt16
#     classification::UInt8
#     #normalSphereMapped::Array{UInt8, 2}
#     #normalOCT16::Array{UInt8, 2}
#     #normal::Array{Float32, 3}
#     #returnNumber::UInt8
#     #numberOfReturns::UInt8
#     #sourceID::UInt16
#     #indices::UInt32
#     #spacing::Float32
#     #gpsTime::Float32 #should be Double
# end

# function readPositionCartesian(fname::String)
# buffer = Array{Float32, 3}  #qua voglio un array di array di 3 elementi

# offset = 0 # number of bytes already read

# for i in offset
#     x = Float32
#     y = Float32
#     z = Float32
# end
#     # ToDo: version check
#     # now it should work with 1.7 potree version only
    
#     # 1 read points
#     # to decode points -> (xyz * scale) + boundingBox.min
#     # 2 read rgba
#     # to decode RGBA -> range 0 - 255

#     return 1
# end

using Potree


boundingBoxMin = 1.4770147800445557
scale = 0.001
points = 357003 # total points of potree

fname = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)/data/r/r0.bin"
data = Array{Float32, 1}(undef, 3)
read!(fname, data)

for f in data
    res = f * scale + boundingBoxMin
    println(res)
end
println(data)

fname2 = "../potree/stairsBIN(v1.7)"

io = open(fname2, "r")

n = Int32
data2 = Array{Int32, 1}(undef, 70) # number of files = 70 
println(position(io))
n = read(io, 1)
println(position(io))
data2 = read(io, 4)
println(position(io))
println(reinterpret(Int8, n))

for n in data2
    println(reinterpret(Int8, n))
end

#println(Potree.readhrc(fname2))