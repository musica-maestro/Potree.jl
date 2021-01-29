using Potree
using Visualization
using BenchmarkTools
using Profile
using DataStructures

# potree source folder
potreeBin = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory
potreeLas = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)" # replace this path with local potree directory

# potree source folder
println("bin loading...")
Vtot = Potree.bin2pointcloud($potreeBin)
println("las loading...")
Vtot2 = Potree.source2pc(potreeLas, -1)

println("Same points?")
println(Vtot == Vtot2.coordinates)

println("Same number of points?")
println(size(Vtot)==size(Vtot2.coordinates))

 GL.VIEW(
      [
      Visualization.points(Vtot)
      ]
  ) 

  GL.VIEW(
    [
    Visualization.points(Vtot2.coordinates)
    ]
) 