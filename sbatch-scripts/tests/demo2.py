from mpi4py import MPI
import h5py

comm = MPI.COMM_WORLD
rank = comm.rank  # The process ID (integer 0-3 for 4-process run)
nprocs = comm.Get_size()

f = h5py.File("parallel_test.hdf5", "w", driver="mpio", comm=MPI.COMM_WORLD)

dset = f.create_dataset("test", (nprocs,), dtype="i")
dset[rank] = rank

f.close()
