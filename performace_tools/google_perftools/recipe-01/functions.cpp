#include "functions.hpp"
#include <vector>
#include <cmath>

void busyFunction(int loop) {
    for (int i = 0; i < loop; ++i) {
        std::vector<double> v;
        for (int j = 0; j < 100; ++j) {
            v.push_back(std::sin(j) * std::cos(i));
        }
    }
}

void anotherFunction(int another_loop, int busy_loop) {
    for (int i = 0; i < another_loop; ++i) {
        busyFunction(busy_loop);
    }
}

