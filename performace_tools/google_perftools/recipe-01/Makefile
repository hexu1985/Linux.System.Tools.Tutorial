GPERFTOOLS_DIR = $(HOME)/local/gperftools

CXX = clang++
CXXFLAGS = -g -O3 -mavx2 -Wall -pedantic
LDFLAGS = -Wl,-rpath,$(GPERFTOOLS_DIR)/lib -Wl,--enable-new-dtags -L$(GPERFTOOLS_DIR)/lib
LDLIBS = -lprofiler
PROGRAM = example

SOURCES = example.cpp functions.cpp
OBJECTS = $(patsubst %.cpp,%.o,$(SOURCES))

.PHONY: all 
all: $(PROGRAM)

$(PROGRAM): $(OBJECTS)
	$(CXX) $(LDFLAGS) -o $(PROGRAM) $(OBJECTS) $(LDLIBS)

$(OBJECTS): %.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(OBJECTS) $(PROGRAM) prof.data cpu.prof cpu.svg prof.pdf

