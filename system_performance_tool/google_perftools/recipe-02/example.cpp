#include <iostream>
#include "functions.hpp"

int main() {
    std::cout << "Profiling example started..." << std::endl;
    for (int i = 0; i < 5; ++i) {
        anotherFunction();
        busyFunction();
    }
    std::cout << "Profiling example finished." << std::endl;
    return 0;
}
