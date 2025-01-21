# Artifact Description

This artifact contains the scripts used to reproduce the results of the paper, a git sub-module pointing to the relevant code for the library the project was built upon, and this README.

## Requirements
### Hardware Requirements
-  Multiple Modern x86-64 CPUs
- Multiple NVIDIA GPUs, ideally the A100

The code was primarily tested on the NERSC Perlmutter supercomputer, therefore if the reader has access, the author recommends running this code there.
### Software Requirements
- CMake >= 3.3
- GCC >= 12.3
- Cudatoolkit >= 12.0
- A MPI implementation

## Getting Started
In order to obtain the artifact, please clone and then clone the sub-module via 
  git clone https://github.com/tf-mac/icpe2025-artifact
  git submodule update --init --recursive

Create a build directory at a location of your choosing. The author recommends one inside the CombBLAS directory. Enter the build directory and run

  ```cmake {CombBLAS}
  make MultAccuracyCUDA
  make MultTimingCUDA
```

where {CombBLAS} is the path to the CombBLAS directory. Once this is run, allow some time for each of the make commands to run.

## Running the Scripts

Although these tests can be run directly from the programs produced from the build, the authors recommend running the script. The scripts (accurately named) cover the accuracy of the code and the timing data of the code.

To run a given script, copy it to the build directory, and queue it via 
  ```sbatch ./{script} {matA} {matB}
  ```
where {script} is the script that one wants to run, while {matA} and {matB} are the matrices to be multiplied in the tests. If you want to change the parameters in the timing script (relating to the number of iterations running and if the communication switching is performed), open the script and change these values as desired. Communication switching can be turned off by setting `comm=0`.

For accuracy runs, due to slight differences in the arithmetic GPU and CPU semirings if you have explicit zeros in your matrix you may observe an accuracy difference. Therefore, we ask you do not use matrices with explicit zeros without pre-processing to remove those zeros (in our test set, only Long_dt0 has explicit zeros. Because of this, this matrix is useful for timing tests but must be pre-processed for accuracy tests).

For timing runs, the timing output will be output to a file named according to matrix A. The format will be a CSV, with a label for the number of nodes used, and the columns follow the format of: Tradeoff heuristic (kB), GPU packets, Total packets, Total average runtime, Total average communication time, Total average computation time.

## Reproducing the Results

RMAT A & B: (http://eecs.berkeley.edu/~aydin/CombBLAS_FILES/testdata_combblas1.6.1.tgz)
atmosmodd: (https://sparse.tamu.edu/Bourchtein/atmosmodd)
delaunay: (https://sparse.tamu.edu/DIMACS10/delaunay_n23)
Long\_dt0: (https://sparse.tamu.edu/Janna/Long_Coup_dt0)

To reproduce the results found in the paper, one must download the matrices used in the paper and run the timing results above. Once downloaded, run them using the timing script as described above.
