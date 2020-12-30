using Potree
using FileManager 
using Visualization
using BenchmarkTools
using Profile

# potree source Casaletto
potree = "C:/Users/Alessio/Documents/potreeDirectory/pointclouds/CASALETTO" # replace this path with local potree directory

fmtrie = @btime FileManager.potree2trie(potree)

println("=======================================")

ptrie = @btime Potree.potree2trie(potree)

#= trie = Potree.potree2trie(potree)
all_files = Potree.get_all_values(trie)

PC = Potree.las2pointcloud(all_files...)

# point cloud
GL.VIEW(
    [
    Visualization.points_color_from_rgb(PC.coordinates,PC.rgbs)
    ]
) =#