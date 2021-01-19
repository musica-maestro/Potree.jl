using Potree
using FileManager 
using Visualization

# potree source folder
potree = "C:/Users/Alessio/Documents/potreeDirectory/pointclouds/CAVA" # replace this path with local potree directory

println("==============================================================================")
println("FileManager: potree2triee, get_all_values, las2pointcloud")
FMtrie = FileManager.potree2trie(potree)
FMall_files = FileManager.get_all_values(FMtrie)
FMPC = FileManager.las2pointcloud(FMall_files...)
println("==============================================================================")
println("==============================================================================")
println("Potree: potree2triee, get_all_values, las2pointcloud")
Ptrie = Potree.potree2trie(potree)
PMall_files = Potree.get_all_values(Ptrie)
PPC = Potree.las2pointcloud(PMall_files...)
println("==============================================================================")

println("1")
println(FMtrie == Ptrie)
println("2")
println(FMall_files == PMall_files)
println("3")
println(FMPC == PPC)


# point cloud
GL.VIEW(
    [
    Visualization.points_color_from_rgb(PPC.coordinates,PPC.rgbs)
    ]
) 


# point cloud
GL.VIEW(
    [
    Visualization.points_color_from_rgb(FMPC.coordinates,FMPC.rgbs)
    ]
) 