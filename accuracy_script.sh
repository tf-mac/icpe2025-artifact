#!/bin/bash
#SBATCH -N 4
#SBATCH -C gpu
#SBATCH -G 16
#SBATCH -q regular
#SBATCH -J ScalingTest-ATMOSMODD
#SBATCH --mail-user=tfm62@cornell.edu
#SBATCH --mail-type=ALL
#SBATCH -t 01:00:00
#SBATCH -A m4646

#OpenMP settings:
export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread

#run the application:
#applications may perform better with --gpu-bind=none instead of --gpu-bind=single:1 
matA=$1
matB=$2
srun -n 1 --gpus-per-node=4 ReleaseTests/MultAccuracyCUDA $matA $matB
srun -n 4 --gpus-per-node=4 ReleaseTests/MultAccuracyCUDA $matA $mat
srun -n 9 --gpus-per-node=4 ReleaseTests/MultAccuracyCUDA $matA $matB
srun -n 16 --gpus-per-node=4 ReleaseTests/MultAccuracyCUDA $matA $matB
