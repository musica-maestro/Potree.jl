# las.jl

The core of the package to read potrees made of las or laz files.
The main difference with the [load.jl](https://github.com/marteresagh/FileManager.jl/blob/master/src/Load/las.jl) of (marteseragh)[https://github.com/marteresagh] are stored in the **las2pointcloud** function.

## multithreading on las2pointcloud

This function is crucial because it reads the coordinates and rgbs of each point and each file. The number of files in a potree grows as the potree size grows so if we have a potree with milions and milions of points the multithreading helps to reduce the computation time of the structure.

## benchmarking

357.003 points:
![Benchamrk_small.JPG](https://www.dropbox.com/s/fu2ootzevxjfndk/Benchamrk_small.JPG?dl=0&raw=1)
![Stairs.JPG](https://www.dropbox.com/s/uzt2u49g1deyajo/Stairs.JPG?dl=0&raw=1)

As you can see even if the allocation is bigger the computational time is ~60% less.

### Main Interface

```@docs
Potree.las2pointcloud
```
```@docs
Potree.las2larpoints
```
```@docs
Potree.las2aabb
```
```@docs
Potree.las2color
```
```@docs
Potree.color
```
```@docs
Potree.xyz
```
```@docs
Potree.read_LAS_LAZ
```