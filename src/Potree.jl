__precompile__()

module Potree

    using Common
    using LasIO
    using LazIO
    using JSON
    using PlyIO
    using DataStructures
    using Dates
    using Printf
    using Distributed
    #using PointClouds
    
    # util
    include("struct.jl")
    include("utilities.jl")


    # load
    include("Load/hierarchy.jl")
    include("Load/json.jl")
    include("Load/las.jl")
    include("Load/bin.jl")

    export potree2trie, las2pointcloud, DataStructures, LasIO, LazIO, JSON, getmodel, CloudMetadata,
    HEADER_SIZE, DATA_OFFSET, SIZE_DATARECORD, bin2pointcloud, bin2pointcloudNoMultithreading, las2larpoints, las2color, bin2pointcloudNEW

end