using Potree
using Test

# WARNING : change with your path, just click on the folder and copy-paste path
# path to "../potre/so_on
# I'm just using the same potree version with different output Format
# if u want to change the potree files check if the version is supported

potreeBIN = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)"
potreeLAS = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)"
potreeLAZ = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAZ(v1.7)"

oneNodeBIN = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsBIN(v1.7)/data/r/r0.bin"
oneNodeLAS = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAS(v1.7)/data/r/r0.las"
oneNodeLAZ = "C:/Users/Alessio/.julia/dev/Potree/potree/stairsLAZ(v1.7)/data/r/r0.laz"

# Hardcoded potree infos
# If u change the testing potree u must change these values

totalNodes = 71 # aka number of files
maxDepth = 3    # depth of the tree
totalPoints = (3, 357003) # using that to check coordinates and rgbs ( 3 (xyz/rgb), 357003 (total points))
boundingbox = (1.4770147800445557, -0.7153962850570679, -1.4153246879577637, 5.361339569091797, 3.1689285039901735, 2.4690001010894777)
#las.jl testing

@testset "las2pointcloud" begin
    #@test size(Potree.las2pointcloud((Potree.get_all_values(Potree.potree2trie(potreeBIN)))...).coordinates) == totalPoints
    @test size(Potree.las2pointcloud((Potree.get_all_values(Potree.potree2trie(potreeLAS)))...).coordinates) == totalPoints
    @test size(Potree.las2pointcloud((Potree.get_all_values(Potree.potree2trie(potreeLAZ)))...).coordinates) == totalPoints

    #@test size(Potree.las2pointcloud((Potree.get_all_values(Potree.potree2trie(potreeBIN)))...).rgbs) == totalPoints
    @test size(Potree.las2pointcloud((Potree.get_all_values(Potree.potree2trie(potreeLAS)))...).rgbs) == totalPoints
    @test size(Potree.las2pointcloud((Potree.get_all_values(Potree.potree2trie(potreeLAZ)))...).rgbs) == totalPoints
end

@testset "las2larpoints" begin
    # troppi punti mutua uguaglianza
    @test (Potree.las2larpoints(oneNodeLAS)) == (Potree.las2larpoints(oneNodeLAZ))
    #@test (Potree.las2larpoints(oneNodeBIN)) == (Potree.las2larpoints(oneNodeLAZ))
    #@test (Potree.las2larpoints(oneNodeBIN)) == (Potree.las2larpoints(oneNodeLAS))
end

@testset "las2aabb" begin
    # bounding box punto diverso da bounding potree?
    # @test (Potree.las2aabb(oneNodeLAS)) == boundingbox
    # questo forse si può checkare
end

@testset "las2color" begin
    # Troppi punti mutua uguaglianza
    # Potree.las2color(oneNodeLAS)
end

@testset "color" begin
    # non serve
end

@testset "xyz" begin
    # non serve
end

@testset "read_LAS_LAZ" begin
    # check trasformation las to BIN?
end


#json.jl testing

@testset "json2volume" begin
    
end

@testset "json2LARvolume" begin
    
end

@testset "json2ucs" begin
    
end

@testset "seedPointsFromFile" begin
    
end

#hierarchy.jl testing

@testset "potree2trie" begin
    #cosa restituisce?
end

@testset "max_depth" begin
    @test Potree.max_depth(Potree.potree2trie(potreeBIN)) == maxDepth
    @test Potree.max_depth(Potree.potree2trie(potreeLAS)) == maxDepth
    @test Potree.max_depth(Potree.potree2trie(potreeLAZ)) == maxDepth
end

@testset "cut_trie" begin
    
end

# check if get_all_values reads all files and types

@testset "get_all_values" begin

    # size gives a tuple (totalNodes, ) so use [1] to check the first element 
    
    @test size(Potree.get_all_values(Potree.potree2trie(potreeBIN)))[1] == totalNodes
    @test size(Potree.get_all_values(Potree.potree2trie(potreeLAS)))[1] == totalNodes
    @test size(Potree.get_all_values(Potree.potree2trie(potreeLAZ)))[1] == totalNodes
end

@testset "sub_trie" begin
    
end

@testset "get_files_in_potree_folder + get_files" begin
    
# size gives a tuple (totalNodes, ) so use [1] to check the first element 
    
    # LOD = 0, just one node (radix node)
    @test size(Potree.get_files_in_potree_folder(potreeBIN, 0))[1] == 1
    @test size(Potree.get_files_in_potree_folder(potreeLAS, 0))[1] == 1
    @test size(Potree.get_files_in_potree_folder(potreeLAZ, 0))[1] == 1

    # LOD = 1, radix + 7 child
    @test size(Potree.get_files_in_potree_folder(potreeBIN, 1))[1] == 8
    @test size(Potree.get_files_in_potree_folder(potreeLAS, 1))[1] == 8
    @test size(Potree.get_files_in_potree_folder(potreeLAZ, 1))[1] == 8

    # LOD = 2, radix + 7 child + 26 child of child
    @test size(Potree.get_files_in_potree_folder(potreeBIN, 2))[1] == 36
    @test size(Potree.get_files_in_potree_folder(potreeLAS, 2))[1] == 36
    @test size(Potree.get_files_in_potree_folder(potreeLAZ, 2))[1] == 36

    # LOD = 3, radix + 7 child + 26 child of child + 35 child = totalNodes (71)
    @test size(Potree.get_files_in_potree_folder(potreeBIN, 3))[1] == totalNodes
    @test size(Potree.get_files_in_potree_folder(potreeLAS, 3))[1] == totalNodes
    @test size(Potree.get_files_in_potree_folder(potreeLAZ, 3))[1] == totalNodes
end