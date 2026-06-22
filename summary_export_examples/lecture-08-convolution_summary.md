# Video Structured Summary

> Total 6 chapters

## Table of Contents

1. Introduction and Course Review [00:00-02:04]
2. GPU Architecture Review: Memory Hierarchy and Thread Organization [02:04-06:57]
3. Resource Utilization, Occupancy, and Memory Access Patterns [06:57-13:15]
4. Introduction to Convolution: 1D and 2D Concepts [13:15-31:50]
5. 2D Convolution CUDA Implementation: Basic Kernel [31:50-47:36]
6. Optimization: Tiling for Data Reuse in Convolution [47:36-66:01]

---

---

## Introduction and Course Review [00:00-02:04]

### Timeline Narrative

**[00:00-00:14] | Course Opening and Topic Introduction**
- The instructor welcomes students to Lecture 8 of the GPU computing series and announces that the class will begin discussing parallel patterns today. The first parallel pattern introduced is convolution.
- Before moving into the new topic, the instructor decides to review what earlier lectures covered, since the previous lectures have already taught the fundamentals of GPU computing.

**[00:14-00:29] | Purpose of the Review**
- The instructor explains that before transitioning to the new section on parallel patterns, a quick review is needed to reinforce students' understanding of the basic principles of GPU computing.

**[00:29-00:47] | Processor Trends and the Rise of Parallel Computing**
- Shows the "Processor Trends" chart, with the horizontal axis spanning 1970 to 2020 and the vertical axis including transistor count in thousands, single-thread performance (SpecINT x10^4), frequency in MHz, typical power in Watts, and number of logic cores.
- The instructor points out that early in the course they discussed how thread performance was affected by the power wall, which caused frequency to stagnate. This situation pushed computing toward parallel computing.

**[00:47-01:00] | CPU and GPU Design Comparison: Latency-Oriented vs Throughput-Oriented**
- Shows the "Approaches to Processor Design" slide, with CPU on the left as a latency-oriented design and GPU on the right as a throughput-oriented design.
- CPU design characteristics: a small number of powerful ALUs, which reduce operation latency; large caches, which turn long-latency memory accesses into short-latency cache accesses; and complex control logic, including branch prediction to reduce control hazards and data forwarding to reduce data hazards, to minimize pipeline stalls.
- GPU design characteristics: many small ALUs, where a single operation has higher latency but high throughput, and heavy pipelining further improves throughput; smaller caches, with more chip area devoted to computation; and simpler control logic, again leaving more area for computation.

**[01:00-01:28] | Comparison of Latency Hiding Mechanisms**
- CPUs hide the remaining latency not covered by other techniques through modest multitasking, but the degree of multithreading is limited to minimize data overhead.
- GPUs compensate for high operation latency with a massive number of threads, using thread switching to hide memory access latency and achieve high throughput.

**[01:28-02:04] | System Architecture Review**
- Shows the "Memory Management" slide, explaining how the GPU and CPU typically work together in a system.
- Process steps: 1. allocate GPU memory on the GPU; 2. copy data from CPU main memory to GPU memory; 3. execute computation on the GPU; 4. copy results from GPU memory back to CPU main memory; 5. move data between CPU main memory and GPU memory.
- The instructor emphasizes that the system contains a CPU with main memory, and the GPU is connected to the CPU through a bus such as PCIe, so data must be transferred between the two.

### Key Points Summary

As the introduction to Lecture 8, this chapter first announces convolution as the new topic within parallel patterns. It then systematically reviews the fundamentals of GPU computing: starting from processor trends, where frequency stagnation led to the rise of parallel computing, it compares the fundamental differences between CPU latency-oriented design and GPU throughput-oriented design in ALUs, caches, control logic, and latency hiding mechanisms. It closes by reviewing the cooperative CPU and GPU system architecture and the data management flow.

![00:00](../总结导出案例/lecture-08-convolution_summary/slides/slide_000.cropped.png)
![00:10](../总结导出案例/lecture-08-convolution_summary/slides/slide_001.png)
![00:30](../总结导出案例/lecture-08-convolution_summary/slides/slide_002.cropped.png)
![00:40](../总结导出案例/lecture-08-convolution_summary/slides/slide_003.cropped.png)
![00:50](../总结导出案例/lecture-08-convolution_summary/slides/slide_004.cropped.png)


---

## GPU Architecture Review: Memory Hierarchy and Thread Organization [02:04-06:57]

### Timeline Narrative

**[02:04-02:28] | Basic GPU Memory Management Flow**
- Typical GPU usage: the CPU has main memory, and the GPU has its own device memory.
- Standard operation flow:
  1. Allocate GPU memory on the GPU.
  2. Copy data from CPU main memory to GPU memory.
  3. Execute the kernel on the GPU while accessing data in GPU memory.
  4. Copy results back from GPU memory to CPU main memory.
  5. Deallocate GPU memory.
- Other approaches also exist, such as Unified Memory, where data can be allocated on the CPU and used directly on the GPU.

**[02:41-03:08] | Data Parallelism and Vector Addition Review**
- Starting from the simple vector addition kernel, shows the concept of data parallelism.
- Data parallelism is a typical use case for GPUs, and vector addition is called the "Hello World" of data parallelism.
- The grid is organized into threads and blocks, and operations are executed by computing the thread index:
```cuda
int i = blockDim.x * blockIdx.x + threadIdx.x;
```
- Each thread applies the same operation to a different piece of data.

**[03:08-03:44] | Multidimensional Grids and Data Layout**
- A grid can be organized as a multidimensional array, such as 2D grids and 3D grids.
- Built-in dimension variables contain x, y, and z components, such as gridDim.y and gridDim.z.
- Multidimensional data is laid out in memory in row-major order.
- When accessing multidimensional data, index calculation is needed to convert 2D indices into a 1D index for accessing a dynamic array:
  - Logical view: a 2D table, such as a 4x4 matrix.
  - Actual memory layout: a 1D contiguous array arranged by rows.

**[03:44-03:58] | Examples of Multidimensional Data Access**
- RGB to grayscale conversion.
- Image blur, which is a special case of convolution.
- Matrix-matrix multiplication, an example that will continue to be used in later lectures.

**[04:08-04:38] | GPU Architecture and SM Organization**
- A GPU consists of multiple Streaming Multiprocessors, or SMs.
- Each SM contains multiple cores that share a control unit and memory.
- All SMs can access the same global memory.
- For example, a Volta V100 GPU has 80 SMs, each SM has 64 cores, for a total of 5120 cores.
- When a grid is scheduled onto SMs, assignment is performed at block granularity, which is block-aware parallelism.
- All threads in the same block run concurrently on the same SM.
- Multiple thread blocks can run on a single SM at the same time.

**[04:38-05:08] | Warp Scheduling and SIMD Execution**
- After a block is scheduled onto an SM, it is further divided into warps.
- A warp is the unit of scheduling in an SM.
- Warp size varies by device, but so far it has always been 32 threads.
- Threads in the same warp execute according to the SIMD model: all threads execute the same instruction while processing different data.
- Note: warp size may change in the future and shouldn't be assumed to always be 32.

**[05:08-05:57] | Control Divergence**
- If threads in the same warp need to take different control paths, control divergence occurs.
- Example: the conditional statement `if(threadIdx.x < 24) { A } else { B }`.
- Execution mechanism:
  1. All threads first execute the then part, where threads with threadIdx.x < 24 are active and the rest are inactive.
  2. Then all threads execute the else part, where threads with threadIdx.x >= 24 are active and the rest are inactive.
- Inactive threads occupy cores but don't execute any operation, causing hardware underutilization.
- Control divergence should be minimized as much as possible. Related optimization patterns will be discussed later.

**[06:01-06:38] | Latency Hiding**
- By scheduling more warps and threads on an SM than the number of cores, thread oversubscription is achieved.
- When a warp encounters a long-latency operation:
  1. Remove that warp.
  2. Schedule another ready warp to execute.
  3. Keep switching to new warps until the original warp finishes the long-latency operation.
- This hides latency and improves hardware use.

**[06:38-06:57] | Occupancy Constraints**
- Occupancy concept: the maximum number of threads that can be scheduled on each SM.
- Different devices have different occupancy limits. For example, V100 supports 2048 threads per SM.
- Other constraints include:
  - Maximum blocks per SM.
  - Number of registers used by each thread.
  - Shared memory capacity.
- Example device parameter table:

| Parameter | K40 | M40 | P100 | V100 |
|------|-----|-----|------|------|
| Microarchitecture | Kepler | Maxwell | Pascal | Volta |
| Compute capability | 3.5 | 5.2 | 6.0 | 7.0 |
| Number of SMs | 15 | 24 | 56 | 80 |
| Cores per SM | 192 | 128 | 64 | 64 |
| Max threads per SM | 2048 | 2048 | 2048 | 2048 |
| Max blocks per SM | 16 | 32 | 32 | 32 |
| Max threads per block | 1024 | 1024 | 1024 | 1024 |
| Registers per SM | 64K | 64K | 64K | 64K |

### Key Points Summary

This chapter reviews the memory hierarchy in GPU architecture, including the data transfer flow between CPU main memory and GPU device memory, and thread organization through the grid, block, and warp hierarchy. Core topics include multidimensional grid index calculation and row-major data layout, SM architecture and block-aware parallel scheduling, the SIMD execution model of warps and the control divergence it can cause, the mechanism of latency hiding through thread oversubscription, and the various hardware constraint parameters that affect occupancy.

![02:10](../总结导出案例/lecture-08-convolution_summary/slides/slide_008.cropped.png)
![03:10](../总结导出案例/lecture-08-convolution_summary/slides/slide_011.cropped.png)
![03:50](../总结导出案例/lecture-08-convolution_summary/slides/slide_014.cropped.png)
![04:30](../总结导出案例/lecture-08-convolution_summary/slides/slide_017.cropped.png)
![05:10](../总结导出案例/lecture-08-convolution_summary/slides/slide_020.cropped.png)


---

## Resource Utilization, Occupancy, and Memory Access Patterns [06:57-13:15]

### Timeline Narrative

**[06:57-07:10] | Resource Use and Occupancy Review**
- Reviews each SM's resource constraints: the number of registers per thread, the shared memory capacity available to the SM, and the maximum number of thread blocks each SM can hold.
- Emphasizes the importance of understanding resource use, with the goal of maximizing the number of threads on an SM, meaning high occupancy.
- Example key parameters: the Kepler architecture has a maximum of 2048 threads per SM, 16 blocks per SM, and 32K registers per SM; the Maxwell architecture has a maximum of 64K registers per SM.

**[07:10-07:30] | Shared Memory in GPU Architecture**
- Shows the internal structure of an SM in the GPU architecture, including the Control unit, Registers, SPs, Constant Cache, and Shared Memory/L1 Cache.
- Threads on the same SM can access that SM's shared memory, while different SMs share the L2 Cache.
- Purpose of shared memory: place data that will be reused into shared memory so all threads in the same block can access it cooperatively.

**[07:30-08:20] | Tiled Matrix Multiplication Example**
- Background: in the traditional method, each thread needs to load an entire row of matrix A and an entire column of matrix B, causing many global memory accesses.
- Optimization method: threads in the same block cooperatively load tiles of A and B into shared memory.
  - Step 1: each thread loads only one element from the tile into shared memory, meaning one element per thread.
  - Step 2: after all threads wait for one another to finish loading, they compute their own partial sums from shared memory.
- Formula: `Ctile = Atile × Btile`.
- Effect: minimizes the number of global memory accesses and improves the ratio of computation to global memory access.

**[08:20-09:10] | DRAM Organization and Burst Access**
- Accessing the DRAM array is slow, but once a DRAM burst is obtained, accessing data within the burst is relatively fast.
- Best practice: threads should access data within the same DRAM burst.
  - Accessing data from different bursts: each access requires accessing the DRAM array again.
  - Accessing data from the same burst: the DRAM array only needs to be read once, and later accesses are served directly from the burst.
- DRAM bank structure: includes a Row Decoder, DRAM Array, Sense Amps, Column Latches, and Mux.
- Access flow: Row Address → DRAM Array (slow) → Sense Amps → Column Latches → Mux (relatively fast).

**[09:10-09:40] | Multiple DRAM Banks and Latency Hiding**
- With multiple DRAM arrays, access latency can be hidden: while reading from the array of one DRAM bank, data can be served from the burst of another bank at the same time.
- This is another motivation for maximizing GPU occupancy: high occupancy not only helps hide pipeline latency, but also provides many memory accesses to hide memory access latency.
- With a single bank, time is wasted between bursts; multiple banks can eliminate this waste.
- Many threads must access memory at the same time to keep all banks busy.

**[09:40-10:10] | Common Optimization Checklist**
- A common optimization checklist was developed, containing the following optimization items and their effects:

| Optimization | What It Improves | Effect on Cores | Effect on Memory |
|------|----------|--------------|--------------|
| Adjust resources to maximize occupancy | Latency hiding | More work to hide pipeline latency | More accesses to hide DRAM latency |
| Minimize control divergence | SIMD efficiency | Fewer idle cores during SIMD execution | None |
| Coalesce memory access patterns | Memory coalescing | Fewer pipeline stalls waiting for memory | Better use of bursts/cache lines |
| Shared memory tiling | Data reuse | Fewer pipeline stalls waiting for memory | Less global memory traffic |
| Thread coarsening | Parallelization overhead | Less redundant work or synchronization | Less global memory traffic |

- Which optimization to choose depends on the bottleneck encountered by the application.

**[10:10-10:55] | Bottleneck Analysis and Profiling Tools**
- Bottleneck definition: the constraint that limits an application's performance on a device.
- The bottleneck depends on both the application and the device itself.
- Optimization is fundamentally a tradeoff among resources: use abundant resources in exchange for bottleneck resources.
- The bottleneck must be diagnosed correctly before applying an optimization, otherwise the wrong resource may be optimized.
- CUDA provides profiling tools to assess resource use.
- Profiling tools can display metrics such as Compute utilization, Memory (Device) utilization, Memory operations, and Control-flow operations.
- Analysis can determine which resources are fully used and which are underused, thereby identifying the bottleneck.

**[11:00-11:40] | Course Structure Review and Outlook**
- The first part, GPU computing fundamentals, ends here and covered vector addition, matrix multiplication, and tiled matrix multiplication.
- The second part will discuss parallel patterns in depth, including convolution, reduction, scan, and histogram.
- Each parallel pattern will introduce new architecture features or optimization techniques.
- Course schedule: Weeks 1-3 are fundamentals, Weeks 4-7 are parallel patterns, and Weeks 8-13 are the project phase.

**[11:40-12:10] | Introduction to the Convolution Pattern**
- Today's topic: Convolution, the first parallel pattern.
- Also introduces a new feature of GPU architecture and the CUDA programming model: constant memory.
- Definition of the convolution operation: an operation in which each element in the output is a weighted sum of input elements and their neighbors.

**[12:10-13:15] | Detailed Explanation of the Convolution Operation**
- 2D convolution example: each output element is a weighted sum of the corresponding input element and its neighbors.
- Image blur is a special case of convolution in which all weights are the same.
- More general convolution form: each input element can have a different weight, and these weights are determined by the convolution mask.
- Output element calculation formula: `output[x][y] = Σ(input[x+i][y+j] × weight[i][j])`, where i and j iterate over the convolution kernel range.

### Key Points Summary

This chapter reviews the core concepts of GPU resource use and occupancy, using tiled matrix multiplication to show how shared memory reduces global memory accesses. It analyzes DRAM organization in depth, explains how burst access and multiple banks affect performance, and emphasizes the importance of high occupancy for hiding memory latency. Finally, it introduces a common optimization checklist and bottleneck analysis methods, laying the groundwork for later study of parallel patterns, especially convolution, and the constant memory feature.

![07:10](../总结导出案例/lecture-08-convolution_summary/slides/slide_026.cropped.png)
![07:40](../总结导出案例/lecture-08-convolution_summary/slides/slide_029.cropped.png)
![08:40](../总结导出案例/lecture-08-convolution_summary/slides/slide_032.cropped.png)
![09:40](../总结导出案例/lecture-08-convolution_summary/slides/slide_035.cropped.png)
![10:50](../总结导出案例/lecture-08-convolution_summary/slides/slide_038.cropped.png)


---

## Introduction to Convolution: 1D and 2D Concepts [13:15-31:50]

### Timeline Narrative

**[13:15-13:56] | Convolution Mask and Weighted Average**
- The instructor introduces the core concept of convolution: each output element is a weighted sum of neighboring input elements, and the weights are determined by the convolution mask.
- To avoid confusion with a CUDA kernel, the convolution kernel is deliberately called a "mask" rather than the usual term "kernel".
- The mask consists of a set of weights. Applying these weights to the input computes a weighted average and produces the output value.
- The slide shows the title "Convolution", with an "input" grid on the left in blue, a small "mask" grid in the center highlighted in orange, an "output" grid on the right with green dots, and the text at the bottom: "Every output element is a weighted sum of the neighboring input elements".

**[14:00-14:44] | Applications of Convolution**
- Convolution is widely used in signal processing, image processing, video processing, and other fields to transform 1D signals or 2D pixels into more desirable values.
- Specific application examples:
  - Gaussian blur: pixels farther from the center have smaller weights, making it more complex than the simple blur introduced earlier.
  - Image sharpening.
  - Edge detection.
- The transformation effect produced by a convolution operation depends entirely on the weight values in the mask.
- The slide is titled "Applications of Convolution" and lists the application points above.

**[14:52-15:15] | 1D, 2D, and 3D Convolution**
- The instructor uses 2D convolution as the example in this lecture because it is easy to visualize and complex enough.
- Also points out that convolution can be 1D, for processing signals, 2D, for processing images, or 3D.
- Text at the bottom of the slide: "Using 2D as an example, but can also be 1D or 3D".

**[15:17-16:12] | Parallelization Strategy for Convolution**
- Question: based on what has been learned, how should convolution be parallelized?
- A student answers: similar to matrix multiplication, split the image into matrices, multiply corresponding values, and accumulate them.
- The instructor points out a simpler approach: similar to the image blur implemented earlier, assign one thread to each output pixel.
- Parallelization method: each output element corresponds to one thread, and that thread iterates over neighboring input elements and the mask to compute the weighted sum.
- The slide shows the title "Parallelizing Convolution", an "input" grid on the left, a "mask" grid in the center, an "output" grid on the right, and the text at the bottom: "Parallelization approach: Assign one thread to compute each output element by looping over input elements and mask weights".

**[16:27-16:47] | Explanation of the Simple Parallel Method**
- This is not the only way to parallelize convolution. Other approaches exist, but this lecture uses the simple method.
- Each thread is responsible for one output element and computes it by looping over the input and the mask.

**[16:47-17:28] | Mask Properties and Introduction of Constant Memory**
- The mask is usually small, e.g. 5×5.
- The mask accessed by all threads is the same.
- The mask doesn't change during kernel execution, meaning the weights stay constant.
- Based on these properties, the mask can be stored in a special type of memory, constant memory, to achieve faster access.
- The slide shows the title "Storing the Mask" and lists these observations:
  - The mask is typically small
  - The mask is constant (weights do not change)
  - The mask is accessed by all threads in the grid
- Optimization approach: store the mask in constant memory for quicker access.

**[17:56-18:33] | Review of Memory in the CUDA Programming Model**
- Reviews the memory hierarchy in the CUDA programming model:
  - Each thread has its own registers.
  - Threads in the same thread block share shared memory.
  - All threads in the grid can access global memory.
- Adds that all threads in the grid can also access constant memory.
- Goal: place the mask in constant memory, since constant memory access is faster than global memory access.
- The slide shows the title "Recall: Memory in the CUDA Programming Model", and the diagram includes levels such as Shared Memory, Registers, Global Memory, and Constant Memory.

**[18:40-19:15] | How to Use Constant Memory: Code Overview**
- Switches to a code demonstration and shows a prepared convolution implementation framework.
- Code structure:
  - Allocate input and output memory on the GPU.
  - Copy input data to the GPU.
  - Copy the mask to constant memory.
  - Launch the convolution kernel.
  - Copy the result back to the host.
  - Free the allocated memory.

**[19:18-19:52] | Declaring a Constant Memory Array**
- Use the `__constant__` keyword at global scope to declare a constant memory array.
- Code example:
```c
__constant__ float mask_c[MASK_DIM][MASK_DIM];
```
- Naming convention: use the `_c` suffix to indicate constant memory, similar to `_d` for device memory and `_h` for host memory.
- The mask size is determined by macro definitions:
```c
#define MASK_RADIUS 2
#define MASK_DIM ((MASK_RADIUS)*2 + 1)  // Result is 5
```

**[21:28-22:00] | Copying Data from the Host to Constant Memory**
- Constant memory cannot be written during GPU execution and must be copied from the CPU side.
- Use the `cudaMemcpyToSymbol` function to copy data from the host to GPU constant memory.
- Code example:
```c
cudaMemcpyToSymbol(mask_c, mask, MASK_DIM * MASK_DIM * sizeof(float));
```
- Parameter explanation:
  - Destination pointer: `mask_c`, the array name in constant memory.
  - Source pointer: `mask`, the mask array on the host side.
  - Size: `MASK_DIM * MASK_DIM * sizeof(float)`.

**[23:01-23:52] | Constant Memory Limitations**
- One important limitation of constant memory: at most 64KB can be allocated.
- This means the entire input matrix cannot be placed in constant memory, even though the input data is also constant and doesn't change.
- The slide shows the title "Using Constant Memory" and lists these points:
  - Declare constant memory array as global variable
  - Must initialize constant memory from the host (cannot modify during execution)
  - Can only allocate up to 64KB
  - Otherwise, input is also constant, but it is too large to put in constant memory

**[24:00-27:00] | Motivation and Advantages of Constant Memory**
- Why is constant memory faster? The motivations are as follows:
  1. **Easier to build an efficient cache**: the data is constant, so the cache only needs to support reads and doesn't need to support writes.
     - No dirty bits or write-back mechanism are needed.
     - No cache coherence issues need to be handled.
     - Multiple threads accessing the same cache line at the same time don't create conflicts.
  2. **Small capacity reduces cache eviction**: constant memory is small in total, 64KB, which leads to a high cache hit rate and fewer evictions.
- The slide shows the title "Motivation for Constant Memory" and gradually lists the advantages above.

**[27:07-27:23] | Constant Cache in GPU Architecture**
- From the programming model perspective, all threads access the same constant memory. At the hardware level, however, each SM has its own constant cache, which caches constant memory data.
- Constant cache is different from L1 cache or shared memory.
- The slide shows the title "Recall: Memory in the GPU Architecture". The diagram shows components inside the SM, including Control, Registers, Constant Cache, Shared Memory, and L1 Cache, with L2 Cache at the bottom.

**[27:34-28:24] | Student Question: Why Not Use Shared Memory?**
- A student asks: since the kernel is small, why not put the mask directly into shared memory, the SM cache?
- The instructor answers: shared memory is managed by the programmer, so the mask must be manually loaded and placed into shared memory; constant cache is managed automatically by hardware, so the programmer doesn't need extra operations.
- Text at the bottom of the slide: "but shared memory is managed by the programmer".

**[28:40-29:10] | Writing the Convolution Kernel Code**
- After declaring constant memory and copying the data, the instructor begins writing the convolution kernel function.
- The kernel code is very similar to the image blur kernel: assign one thread to each output element.
- Compute the indices of the output row and column:
```c
int outRow = blockIdx.y * blockDim.y + threadIdx.y;
int outCol = blockIdx.x * blockDim.x + threadIdx.x;
```

**[30:30-31:00] | Boundary Conditions and Accumulator Initialization**
- Add a boundary condition check to ensure that only threads located within the input range perform computation:
```c
if (outRow < height && outCol < width) {
    // Perform computation
}
```
- Initialize the accumulator variable:
```c
float sum = 0.0f;
```

**[31:00-31:50] | Looping Over the Mask and Input**
- Next, loops need to be written to iterate over neighboring input elements and mask weights and compute the weighted sum.
- The loop bounds are the mask dimension, MASK_DIM.
- The instructor points out that looping over the input and the weighted sum effectively means looping over the mask elements.

### Key Points Summary

This chapter introduces the basic concepts of convolution, including weighted averages and mask weights, and explains how to parallelize convolution efficiently in CUDA. The core strategy is to assign one thread to each output element and store the mask in constant memory to speed up access. The advantages of constant memory come from the hardware-managed constant cache, which doesn't need to handle writes or cache coherence issues, and its small capacity, 64KB, which helps maintain a high cache hit rate. Finally, the code demonstration shows how to declare constant memory, copy data into it, and write the framework of a convolution kernel.

![13:40](../总结导出案例/lecture-08-convolution_summary/slides/slide_043.cropped.png)
![18:10](../总结导出案例/lecture-08-convolution_summary/slides/slide_048.cropped.png)
![23:50](../总结导出案例/lecture-08-convolution_summary/slides/slide_053.cropped.png)
![25:00](../总结导出案例/lecture-08-convolution_summary/slides/slide_058.cropped.png)
![26:00](../总结导出案例/lecture-08-convolution_summary/slides/slide_063.cropped.png)


---

## 2D Convolution CUDA Implementation: Basic Kernel [31:50-47:36]

### Timeline Narrative

**[31:50-32:35] | Defining the Mask Loop Bounds**
- The instructor begins writing the loop section in the convolution kernel function and explains that the loop bound is the mask dimension.
- Defines the outer loop: `for(int maskRow = 0; maskRow < MASK_DIM; ++maskRow)`.
- Defines the inner loop: `for(int maskCol = 0; maskCol < MASK_DIM; ++maskCol)`.
- The purpose of these two loops is to iterate over all elements of the mask. For each mask element, the corresponding input value must be found.

**[32:36-33:05] | Motivation for Computing Input Indices**
- The instructor needs to compute the indices for the input row, `inRow`, and input column, `inCol`.
- Returns to the earlier image diagram to explain how to derive the input position from the output position and mask position.
- Current parallelization strategy: assign one thread to each output element, and that thread loops over the mask and input to compute the weighted sum.

**[33:06-34:50] | Student Question: Can the Mask Loops Be Avoided?**
- A student asks whether these loops can be avoided in convolution.
- The student suggests whether the needed work could be iterated through block dependencies, or whether a thread could be assigned to each input element.
- The instructor answers that these two loops can be parallelized, but doing so is only beneficial when output parallelism is very low.
- For typical large outputs, thousands of pixels by thousands of pixels, assigning one thread to each output already provides enough parallelism.
- If the output is very small and the GPU is underused, then it may be worth extracting parallelism from the mask.
- In practice, thread coarsening is sometimes needed instead, where each thread serially processes multiple output elements.

**[34:51-36:30] | Formula for Computing the Input Row Index**
- The instructor returns to writing the code. The output row, `outRow`, output column, `outCol`, mask row, `maskRow`, and mask column, `maskCol`, are already available.
- The corresponding input row and input column need to be found.
- Example: suppose the output row points to an element, and the mask row is 0, the first row. The corresponding input row is the output row minus the mask radius.
- The mask radius is 2, and the mask dimension is 5.
- Formula derivation: `inRow = outRow - maskRadius + maskRow`.
- When maskRow=0, inRow = outRow - maskRadius; when maskRow=1, inRow = outRow - maskRadius + 1.

**[36:31-38:20] | Formula for Computing the Input Column Index**
- Similarly, the input column formula is `inCol = outCol - maskRadius + maskCol`.
- When maskCol=0, inCol = outCol - maskRadius; when maskCol=1, inCol = outCol - maskRadius + 1.
- The mask radius is defined as 2, and the mask dimension is defined as `2 * maskRadius + 1 = 5`.
- The complete code framework is as follows:

```c
#include "common.h"
#include "timer.h"

#define OUT_TILE_DIM 32

__constant__ float mask_c[MASK_DIM][MASK_DIM];

__global__ void convolution_kernel(float* input, float* output, unsigned int width, unsigned int height) {
    int outRow = blockIdx.y * blockDim.y + threadIdx.y;
    int outCol = blockIdx.x * blockDim.x + threadIdx.x;

    if(outRow < height && outCol < width) {
        float sum = 0.0f;
        for(int maskRow = 0; maskRow < MASK_DIM; ++maskRow) {
            for(int maskCol = 0; maskCol < MASK_DIM; ++maskCol) {
                int inRow = outRow - MASK_RADIUS + maskRow;
                int inCol = outCol - MASK_RADIUS + maskCol;
                // Boundary check and accumulation
            }
        }
    }
}
```

**[38:21-39:30] | Accumulating the Weighted Sum**
- After the input row and input column are available, accumulation can be performed: `sum += mask_c[maskRow][maskCol] * input[inRow * width + inCol]`.
- The instructor first writes the accumulation and then handles the boundary check, because after writing the indices it is easier to extend the boundary check.
- The mask array is indexed with the mask row and mask column, and the input array is indexed with the input row and input column.
- Input index calculation: `inRow * width + inCol`.

**[39:31-42:50] | Implementing the Boundary Check**
- It is necessary to ensure that the input indices are within the valid range, because output elements may be on the edge, causing some input elements to go out of bounds.
- The mask indices, `maskRow` and `maskCol`, are always between 0 and MASK_DIM, so they don't need to be checked.
- The input row and input column need to be checked:
  - `inRow >= 0 && inRow < height`
  - `inCol >= 0 && inCol < width`
- Complete boundary check code:

```c
if(inRow >= 0 && inRow < height && inCol >= 0 && inCol < width) {
    sum += mask_c[maskRow][maskCol] * input[inRow * width + inCol];
}
```

**[42:51-43:42] | Discussing Control Divergence**
- A student asks whether the boundary check causes control divergence.
- The instructor answers yes, but the degree of control divergence is not high because most threads are within the valid range.
- Only a small number of threads at the edges experience control divergence.
- In practice, this divergence is unavoidable and not worth optimizing.
- The control divergence that truly needs optimization is the kind where all threads experience divergence. Examples will be given in later lectures.

**[43:43-44:35] | Storing the Output Element**
- After accumulation is complete, the final step is to store the output element: `output[outRow * width + outCol] = sum`.
- A student points out an error in the code: the input index should use `inCol` rather than `col`.
- The instructor thanks the student for the feedback and corrects it to `input[inRow * width + inCol]`.

**[44:36-45:20] | Compiling, Running, and Performance Results**
- Compile and run the code. The terminal commands are as follows:

```bash
ie22@Dell7820:~/cmps297S-396AA/convolution$ make
nvcc -c -o kernel.o kernel.cu
nvcc main.o kernel.o -o convolution
ie22@Dell7820:~/cmps297S-396AA/convolution$ ./convolution
```

- Performance output:

```
CPU time: 2051.213980 ms
Allocation time: 0.662000 ms
Copy to GPU time: 27.743001 ms
Copy to GPU constant memory time: 0.089000 ms
Kernel time: 5.172000 ms
Copy from GPU time: 47.584999 ms
Deallocation time: 4.482000 ms
GPU time: 85.772000 ms
```

- CPU time is about 2000 ms, while GPU kernel time is only 5 ms. Including copy time, total GPU time is 85 ms, giving a significant performance improvement.

**[45:21-46:25] | Performance Analysis Discussion**
- A student asks why convolution has a larger speedup than vector addition.
- The instructor explains the reasons:
  1. Convolution has substantial data reuse, so cache use is good.
  2. One input, the mask, is stored in constant memory, so access is fast.
  3. The other input, in global memory, has a regular access pattern, so memory accesses are coalesced.
  4. Threads in the same block reuse nearby data.

**[46:26-47:36] | Data Reuse Observation and Optimization Hint**
- Returns to the code slide and observes the data reuse pattern.
- The thread processing one output element uses a set of input elements.
- The input elements used by the next thread overlap heavily with those used by the previous thread.
- The instructor asks: based on this observation, what optimization can we do to capture data reuse?
- A student answers: thread coarsening? The instructor says this is not quite correct.
- Hint: what optimization for data reuse was learned earlier? This suggests tiling.

### Key Points Summary

This chapter implements a basic 2D convolution CUDA kernel using the parallelization strategy where each thread computes one output element. Core topics include iterating over mask elements through nested loops, computing the corresponding input indices with the formulas `inRow = outRow - maskRadius + maskRow` and `inCol = outCol - maskRadius + maskCol`, adding boundary checks to prevent out-of-bounds access, and accumulating the weighted sum before storing the result. After compilation and execution, the GPU kernel takes only 5 ms, achieving about a 400x speedup compared with the CPU's 2000 ms. The performance improvement comes from data reuse, constant memory use, and a regular memory access pattern. Finally, the chapter raises the data reuse optimization problem, preparing for the later tiling optimization.

![33:40](../总结导出案例/lecture-08-convolution_summary/slides/slide_069.cropped.png)
![36:30](../总结导出案例/lecture-08-convolution_summary/slides/slide_070.cropped.png)


---

## Optimization: Tiling for Data Reuse in Convolution [47:36-66:01]

### Timeline Narrative

**[47:36-48:40] | Basic Idea of Tiling Optimization**
- The instructor points out that the main method for optimizing convolution is data reuse, and proper tiling is the key optimization for achieving data reuse.
- Observation shows that all threads in the same thread block use some of the same input data: one output tile corresponds to one input tile.
- Optimization approach: let each thread load only one input element into shared memory, so other threads can access that element from shared memory instead of every thread repeatedly loading it from global memory.
- Specific method: all threads collectively load the entire input tile into shared memory, with each thread loading one element. Then these threads loop over the mask and input tile in shared memory to perform the convolution operation.

**[48:40-49:40] | Size Difference Between Input Tile and Output Tile**
- The instructor points out an important difference between tiling in convolution and tiling in matrix multiplication: in matrix multiplication, the input tile and output tile have the same size, and each thread loads one input element and computes one output element.
- In convolution, however, the input tile is actually larger than the output tile. The specific relationship is:
  - Input tile size = output tile size + 2 × mask radius.
  - For example, if the mask size is 5×5, then the mask radius is 2, and the input tile is larger than the output tile by 2 elements on each side.

**[49:40-51:40] | Thread Assignment Strategy**
- Since the input tile and output tile have different sizes, each thread cannot simply load one input element and compute one output element.
- Solution: the size of the thread block, meaning the number of threads, corresponds to the number of elements in the input tile. In other words, thread block size = input tile size.
- All threads are active when loading the input tile, but only some threads, those corresponding to elements in the output tile, are active when computing and storing the output tile.
- This strategy is called "over provisioning": some threads are only responsible for loading input data and don't participate in computation.
- Another possible approach is to make the number of threads equal to the number of output tile elements, and then let these threads loop to load the input tile, but this method makes the code more complex and provides limited performance improvement.

**[51:40-52:30] | Assignment Instructions**
- The instructor explains that the next assignment will require students to implement tiled convolution code themselves.
- Specific requirement: launch a number of threads equal to the number of input tile elements, use all threads to load the input tile, and use only some threads to compute the output tile.

**[52:30-55:00] | Analysis of Compute-to-Memory-Access Ratio Without Tiling**
- Assume the mask size is M×M and analyze the compute-to-global-memory-access ratio of the untiled version.
- Number of global memory loads per thread: each thread needs to load M² input elements, with each element being 4 bytes, so the global memory load amount is M² × 4 bytes.
- Number of floating-point operations per thread: each output element requires M² multiplications and M² additions, for a total of 2M² floating-point operations.
- Compute-to-memory-access ratio = 2M² OP / (4M² B) = 0.5 OP/B, operations per byte.
- Note: the mask is stored in constant memory and isn't counted in global memory loads.

**[55:00-56:10] | Analysis of Compute-to-Memory-Access Ratio With Tiling**
- When analyzing the tiled version, it is more convenient to analyze at the thread-block level, because some threads only load data and don't participate in computation.
- Number of operations per thread block:
  - Output tile size = T, assuming the input tile size is T, then output tile size is T-M+1.
  - Each output element requires M² multiplications and M² additions, for a total of 2M² floating-point operations.
  - Total operations = (T-M+1)² × 2M² OP.
- Global memory load amount per thread block:
  - The input tile size is T, and each element is 4 bytes.
  - Total load amount = T² × 4 B.
- Compute-to-memory-access ratio = [(T-M+1)² × 2M²] / (T² × 4) = 0.5M² × [1 - (M-1)/T]² OP/B.

**[56:10-59:40] | Formula Derivation and Numerical Example**
- The instructor derives the formula above in detail and gives a numerical example:
  - When M=5, mask size 5×5, and T=32, input tile 32×32:
  - Compute-to-memory-access ratio = 0.5 × 25 × [1 - 4/32]² = 12.5 × (7/8)² ≈ 9.57 OP/B.
- Compared with 0.5 OP/B in the untiled version, tiling brings about a 19x improvement.
- The instructor points out that tiled matrix multiplication under the same conditions, a 32×32 tile, can bring a 32x improvement, because in matrix multiplication the input tile and output tile have the same size and there is no "boundary overhead".

**[59:40-61:40] | Effect of Data Type on the Compute-to-Memory-Access Ratio**
- A student asks: convolution is mainly used for image processing, so can integers, such as 8-bit integers, be used instead of floating-point numbers for optimization?
- The instructor answers that if the input data is 8-bit integers, 1 byte, then the compute-to-memory-access ratio changes accordingly:
  - Global memory load amount becomes T² × 1 byte instead of 4 bytes.
  - Floating-point operations become integer operations.
  - This is essentially a different type of convolution, not an optimization technique.
- If floating-point computation is truly required, such as in non-image applications, then floating-point numbers must be used.

**[61:40-64:10] | Handling Boundary Conditions**
- The instructor introduces methods for handling boundary conditions in tiled convolution:
- Method 1: after loading the input tile into shared memory, check during computation whether the original global memory access is out of bounds.
- Method 2, more common: while loading the input tile, directly load a value of 0 into shared memory for out-of-bounds elements, called ghost elements.
- Benefit of Method 2: during computation in shared memory, all elements are valid, so boundary conditions don't need to be checked again, and the code is simpler.

**[64:10-66:01] | Course Summary and Textbook Reference**
- The instructor summarizes that tiling significantly improves the compute-to-memory-access ratio and is the core method for optimizing convolution.
- Recommends that students read Chapter 7 of the textbook, David B. Kirk and Wen-mei W. Hwu. Programming Massively Parallel Processors: A Hands-on Approach, Morgan Kaufmann, 2016, for more details.
- The instructor asks whether there are any final questions and ends the class if there are none.

### Key Points Summary

The core content of this chapter is the optimization technique of using tiling to achieve data reuse in convolution operations. Key points include: the input tile size is larger than the output tile size by twice the mask radius; over-provisioning threads, with the number of threads equal to the number of input tile elements, separates loading from computation; tiling can raise the compute-to-memory-access ratio from 0.5 OP/B to about 9.57 OP/B, a 19x improvement; and boundary conditions can be simplified by loading 0 values into shared memory. The learning goals are to understand the principle of tiled convolution, the derivation method for the compute-to-memory-access ratio, and strategies for handling boundary conditions.

![51:30](../总结导出案例/lecture-08-convolution_summary/slides/slide_071.cropped.png)
