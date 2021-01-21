using Potree
using FileManager 
using Visualization
using BenchmarkTools
using Profile

println("Load done")

# potree source folder
potree = "C:/Users/Alessio/Documents/potreeDirectory/pointclouds/scale_1.7/" # replace this path with local potree directory

println("loading trie...")
Ptrie = Potree.potree2trie(potree)
println("searching files...")
PMall_files = Potree.get_all_values(Ptrie)
println("creating point cloud...")
#PPC = Potree.las2pointcloud(PMall_files...)

println(size(PMall_files)[1] == 71)

#  GL.VIEW(
#       [
#       Visualization.points_color_from_rgb(PPC.coordinates,PPC.rgbs)
#       ]
#   ) 