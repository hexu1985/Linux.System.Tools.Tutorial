#include <iostream>
#include <string>

#include "functions.hpp"

int main(int argc, char* argv[]) {
    int busy_loop = 1000000;
    int another_loop = 500;

    if (argc > 1) {
        busy_loop = std::stoi(argv[1]);
    }
    if (argc > 2) {
        another_loop = std::stoi(argv[2]);
    }

    std::cout << "Profiling example started..." << std::endl;
    for (int i = 0; i < 5; ++i) {
        anotherFunction(another_loop, busy_loop);
        busyFunction(busy_loop);
    }
    std::cout << "Profiling example finished." << std::endl;
    return 0;
}
