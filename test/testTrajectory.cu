#define CUASTAR_IMPLEMENTATION 
#define CUASTAR_DEBUG


#include <iostream>
#include <chrono>
#include <iomanip>
#include "../include/cuAStar.hpp"

int main() {
    using T = float;
    using NodeType = Node3d<T>;

    auto start_time = std::chrono::steady_clock::now();

 
    AstarPlanner<Node3d<T>,T> planner("Area_1_Site_93340.ply");
    auto init_time = std::chrono::steady_clock::now();
    std::cout << "Planner initialization time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(init_time - start_time).count() 
              << " ms" << std::endl;

 
    NodeType start(82.029, 48.097, 1.174);
    NodeType end(84.009, 50.173, 2.073);
    planner.setTargetNode(&end);
    planner.setInitialNode(&start);
    auto node_setup_time = std::chrono::steady_clock::now();
    std::cout << "Node setup time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(node_setup_time - init_time).count() 
              << " ms" << std::endl;

 
    planner.computeChunkOpenSet();
    auto chunk_compute_time = std::chrono::steady_clock::now();
    std::cout << "Chunk open set computation time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(chunk_compute_time - node_setup_time).count() 
              << " ms" << std::endl;

 
    planner.computeTrajectory();
    auto traj_compute_time = std::chrono::steady_clock::now();
    std::cout << "Trajectory computation time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(traj_compute_time - chunk_compute_time).count() 
              << " ms" << std::endl;

 
    planner.visualize2dTrajectory("traj2d.png");
    auto visualization_time = std::chrono::steady_clock::now();
    std::cout << "2D Trajectory visualization time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(visualization_time - traj_compute_time).count() 
              << " ms" << std::endl;
 
    std::cout << "Total execution time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(visualization_time - start_time).count() 
              << " ms" << std::endl;

    return 0;
}
