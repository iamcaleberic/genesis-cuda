#include <stdlib.h>
#include <stdio.h>

__global__ void cube(float * d_out, float * d_in){
  int idx = threadIdx.x;
  float f = d_in[idx];
  d_out[idx] = f * f * f;
}

int main(int argc, char ** argv){
  const int ARRAY_SIZE = 96;
  const int ARRAY_BYTES =  ARRAY_SIZE * sizeof(float);

  // generate input array on host
  // practice to declare host starting with h a and device with d
  float h_in[ARRAY_SIZE];
  for (int i = 0; i < ARRAY_SIZE; i++){
    h_in[i] = float(i);
  }
  float h_out[ARRAY_SIZE];

  // declare gpu memory pointers
  float * d_in;
  float * d_out;

  //allocate gpu memory

  cudaMalloc((void **) &d_in, ARRAY_BYTES);
  cudaMalloc((void **) &d_out, ARRAY_BYTES);

  // array transfering to gpu
  cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);

  cube<<<1, ARRAY_SIZE>>>(d_out, d_in);

  // copy back to cpu
  cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

  for(int i = 0; i < ARRAY_SIZE; i++){
    printf("%f", h_out[i]);
    printf(((i % 4) != 3) ? "\t" : "\n");
  };

  // free memory
  cudaFree(d_in);
  cudaFree(d_out);

  return 0;
}
