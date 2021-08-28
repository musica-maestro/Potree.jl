using Potree

struct BinPoints
	x::Int32
	y::Int32
	z::Int32
	r::Int32
	g::Int32
	b::Int32
	a::Int32
end


function Base.read!(io::IO, ::Type{BinPoints})
    BinPoints(convert(Int32, (read(io,UInt8))),convert(Int32, (read(io,UInt8))),convert(Int32, (read(io,UInt8))),convert(Int32, (read(io,UInt8))),convert(Int32, (read(io,UInt8))),convert(Int32, (read(io,UInt8))),convert(Int32, (read(io,UInt8))))
end
fname = "C:/Users/Alessio/Documents/PotreeDirectory/pointclouds/scale_1.8/data/r/r40.bin"
fnamel = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)/data/r/r40.las"
io = open(fname, "r");

# while !eof(io)
#     hcat(points, read!(io, BinPoints))
# end

while !eof(io)
	@show read(io, UInt32)
	@show read(io, UInt32)
	@show read(io, UInt32)
	@show read(io, UInt8)
	@show read(io, UInt8)
	@show read(io, UInt8)
	@show read(io, UInt8)
end

@show las2larpoints(fnamel)
@show las2color(fnamel)

close(io)