struct BinPC
    positionCartesian::UInt32
    sec::UInt8
end

function Base.read(io::IO, ::Type{BinPC})
    BinPC(read(io,UInt32),read(io,UInt8))
end

fname = "C:/Users/Alessio/Documents/potreeDirectory/pointclouds/scale_1.7/data/r/r0.bin"

f = open(fname)
read(f, BinPC)