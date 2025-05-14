#include "functions.hpp"
#include <vector>
#include <cmath>

void busyFunction() {
    for (int i = 0; i < 1000000; ++i) {
        std::vector<double> v;
        for (int j = 0; j < 100; ++j) {
            v.push_back(std::sin(j) * std::cos(i));
        }
    }
}

void anotherFunction() {
    for (int i = 0; i < 500; ++i) {
        busyFunction();
    }
}
