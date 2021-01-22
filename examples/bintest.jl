struct BinPC
    positionCartesian::Array{Float32, 3}
    colorPacked::Array{Int8, 4}
end

function Base.read(io::IO, ::Type{BinPC})
    BinPC(read(io,UInt32),read(io,UInt8))
end

fname = "C:/Users/Alessio/Documents/potreeDirectory/pointclouds/scale_1.7/data/r/r0.bin"

appoggio = Array{Any, Any}
read!(fname, appoggio)
println(appoggio)