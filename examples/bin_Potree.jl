using Potree
using Visualization
using BenchmarkTools
using Profile

using DataStructures

println("Load done")

# potree source folder
potree = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory

println("loading trie...")
Ptrie = Potree.potree2trie(potree)
println("searching files...")
PMall_files = Potree.get_all_values(Ptrie)
for f in PMall_files
    println(f)
end
# println("creating point cloud...")
# PPC = Potree.las2pointcloud(PMall_files...)

println(size(PMall_files)[1] == 71)

metadata = CloudMetadata(potree)
println(metadata.boundingBox)


#  GL.VIEW(
#       [
#       Visualization.points_color_from_rgb(PPC.coordinates,PPC.rgbs)
#       ]
#   ) 