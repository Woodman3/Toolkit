#!/bin/bash
#SBATCH -p thcp3
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --output=./out/%j.out

module load mpich python hpctoolkit openblas
# export OMP_NUM_THREADS=16
echo "Job Name: "${SLURM_JOB_NAME}
echo "Job ID: "${SLURM_JOB_ID}
echo "Partition: "${SLURM_JOB_PARTITION}
echo "Node Num: "${SLURM_JOB_NUM_NODE}
echo "Node List: "${SLURM_JOB_NODELIST}
echo "Proc Num: "${SLURM_NPROCS}
echo "Dir Submit: "${SLURM_SUBMIT_DIR}
echo "OMP_NUM_THREADS: "${OMP_NUM_THREADS}

echo "Ini Time@"`date "+%x %H:%M:%S:%N"`
# ulimit -c unlimited
ulimit -c 0
yhrun ./build/src/virtex
echo "Fin Time@"`date "+%x %H:%M:%S:%N"`
