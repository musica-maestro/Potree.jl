using Potree
using FileManager 
using Visualization
using BenchmarkTools
using Profile

# potree source folder
potree = "C:/Users/Alessio/Documents/potreeDirectory/pointclouds/CAVA" # replace this path with local potree directory

println("==============================================================================")
println("@btime for FileManager: potree2triee, get_all_values, las2pointcloud")
FMtrie = @btime FileManager.potree2trie($potree)
FMall_files = @btime FileManager.get_all_values($FMtrie)
FMPC = @btime FileManager.las2pointcloud($FMall_files...)
println("==============================================================================")
println("==============================================================================")
println("@btime for Potree: potree2triee, get_all_values, las2pointcloud")
Ptrie = @btime Potree.potree2trie($potree)
PMall_files = @btime Potree.get_all_values($Ptrie)
PPC = @btime Potree.las2pointcloud($PMall_files...)
println("==============================================================================")

# Section used to check if there is any difference 
# during the output of the 2 packages

# println("==============================================================================")
# println("==============================================================================")
# println("FMall_files == PMall_files (Next line should be true)")
# println(FMall_files == PMall_files)
# println("==============================================================================")
# println("size(FMPC.coordinates) == size(PPC.coordinates) (Next line should be true)")
# println(size(FMPC.coordinates) == size(PPC.coordinates))
# println("==============================================================================")
# println("==============================================================================")

# Section used to check if there is any difference 
# during the Visualization of the results

# point cloud
# GL.VIEW(
#     [
#     Visualization.points_color_from_rgb(PPC.coordinates,PPC.rgbs)
#     ]
# ) 

# # point cloud
# GL.VIEW(
#     [
#     Visualization.points_color_from_rgb(FMPC.coordinates,FMPC.rgbs)
#     ]
# ) 