# Variables
SRC_DIR := src
CPP_FILES := $(wildcard $(SRC_DIR)/*.cpp)
C_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(CPP_FILES:.cpp=.o) $(C_FILES:.c=.o)
PCH_FILE := $(SRC_DIR)/Common.h
PCH := $(SRC_DIR)/Common.h.gch
OUTPUT_DIR := bin
EXE := $(OUTPUT_DIR)/fluffi-bot

# Compiler
CXX := g++
CC := gcc

# Flags
CXXFLAGS := -O3 -Wall -Wextra -Werror -std=c++20 -pedantic -Weffc++ -Woverloaded-virtual -Wsign-promo  -Wctor-dtor-privacy -Wnon-virtual-dtor -Wno-unused-value -Wno-deprecated-copy -Wreorder -Winvalid-pch -I"./concord/inc" -D_DEBUG
LNKFLAGS := 

# Targets
all: $(PCH) $(EXE)

$(PCH): $(PCH_FILE)
	$(CXX) $(CXXFLAGS) -o $@ -c $<

$(EXE): $(OBJ_FILES)
	@mkdir -vp $(OUTPUT_DIR)
	$(CXX) $(OBJ_FILES) $(LNKFLAGS) -o $@
#	cp -r Assets $(OUTPUT_DIR)
#	cp -r Data $(OUTPUT_DIR)

%.o: %.cpp $(PCH)
	$(CXX) $(CXXFLAGS) -include $(PCH_FILE) -c $< -o $@

%.o: %.c $(PCH)
	$(CXX) $(CXXFLAGS) -include $(PCH_FILE) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(OBJ_FILES) $(EXE) $(PCH)
	rm -rf $(OUTPUT_DIR)
