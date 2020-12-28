using Potree
using Visualization

# potree source CAVA
potree = "C:/Users/Alessio/Documents/potreeDirectory/pointclouds/CASALETTO" # replace this path with local potree directory
trie = Potree.potree2trie(potree)
depth = Potree.max_depth(trie)
all_files = Potree.get_all_values(trie)

PC = Potree.las2pointcloud(all_files...)

# point cloud
GL.VIEW(
    [
    Visualization.points_color_from_rgb(PC.coordinates,PC.rgbs)
    ]
)
