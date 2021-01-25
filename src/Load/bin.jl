"""
    function decodePoint(point::Int32, scale::Float32, boundingBoxMin::Float32) -> Float32

decodes a point of a bin file (https://github.com/PropellerAero/potree-propeller-private/blob/master/docs/file_format.md )
"""
function decodePoint(point::Int32, scale::Float32, boundingBoxMin::Float32)::Float32
	return (x * scale) + boundingBoxMin
end