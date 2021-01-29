using Potree
using FileManager 
using Visualization
using BenchmarkTools
using Profile

# potree source folder
# big files preferable
#potree = "C:/Users/Alessio/Documents/potreeDirectory/pointclouds/CAVA" # replace this path with local potree directory
potree = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)"
potreeBin = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)"

@btime bin2pointcloudNoMultithreading($potreeBin)
@btime bin2pointcloud($potreeBin)