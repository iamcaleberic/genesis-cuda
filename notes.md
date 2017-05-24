* Kernel Launch refers to a call from host to device
    `add<<<N, 1>>>()`
    - N refers to launching multiple instances of add in parallel
* Terminology: each parallel invocation of add() is referred to as a block
   - The set of blocks is referred to as a grid
   - Each invocation can refer to its block index using blockIdx.x
* By using blockIdx.x to index into the array, each block handles a
   different element of the array

 * Using __global__ to declare a function as device code
    - Executes on the device
     - Called from the host
* Terminology: a block can be split into parallel threads
  - We use threadIdx.x instead of blockIdx.x
