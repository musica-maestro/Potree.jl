using Potree
using Visualization
using BenchmarkTools
using Profile

using DataStructures

println("Load done")

# potree source folder
potreeBin = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)" # replace this path with local potree directory
potreeLas = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)" # replace this path with local potree directory

println("creating point cloud for bin...")
Vtot = Potree.bin2pointcloud(potreeBin)

Vtot2 = Potree.source2pc(potreeLas, -1)

println(Vtot == Vtot2.coordinates)

# goodPoints = 0

# for v in Vtot
#     for vinner in Vtot2.coordinates
#         if(v==vinner)
#             splice(Vtot2.coordinates, vinner) 
#             global goodPoints += 1
#         end
#     end
# end

println("Number of good points")
println(goodPoints)
println("Number of 1")
println(size(Vtot))
println("Number of 2")
println(size(Vtot2.coordinates))
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