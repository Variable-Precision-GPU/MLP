CUDA_PATH ?= /usr/local/cuda
CXX = g++
NVCC = nvcc
FLAG = -std=c++11 -O3
LIB = -lm
# SRC = MLP.cpp
SRCCU = MLP_cuda.cu
TARGET = mlp_hardware mlp_sim

all::$(TARGET)

# mlp: $(SRC)
# 	$(CXX) $(FLAG) $(LIB) -o $@ $^

mlp_hardware: $(SRCCU)
	$(NVCC) $(FLAG) $(LIB) -o $@ $^ -lcusparse -lcublas -g

mlp_sim: $(SRCCU)
	$(NVCC) $(FLAG) $(LIB) -o $@ $^ -L$(CUDA_PATH)/lib64 -lcudart -lcublas_static -lcusparse_static -lculibos -gencode arch=compute_60,code=compute_60

clean:
	rm -rf $(TARGET)
