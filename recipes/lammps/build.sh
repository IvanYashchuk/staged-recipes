#!/bin/bash

cd src
make yes-standard no-kim no-gpu no-kokkos no-mpiio no-mscg no-voronoi no-latte no-python yes-user-meamc yes-user-phonon
cd ../lib/meam/
make -f Makefile.gfortran
cd ../poems
make -f Makefile.g++
cd ../reax/
make -f Makefile.gfortran
cd ../../src
make serial LMP_INC="-DLAMMPS_EXCEPTIONS"
# cmake ./cmake -DENABLE_ASPHERE=ON -DENABLE_BODY=ON -DENABLE_CLASS2=ON -DENABLE_COLLOID=ON -DENABLE_COMPRESS=ON -DENABLE_CORESHELL=ON -DENABLE_DIPOLE=ON -DENABLE_GRANULAR=ON -DENABLE_KSPACE=ON -DENABLE_MANYBODY=ON -DENABLE_MC=ON -DENABLE_MEAM=ON -DENABLE_MISC=ON -DENABLE_MOLECULE=ON -DENABLE_PERI=ON -DENABLE_REAX=ON -DENABLE_REPLICA=ON -DENABLE_RIGID=ON -DENABLE_SHOCK=ON -DENABLE_SNAP=ON -DENABLE_SRD=ON -DENABLE_OPT=ON -DENABLE_KIM=OFF -DENABLE_GPU=OFF -DENABLE_KOKKOS=OFF -DENABLE_MPIIO=OFF -DENABLE_MSCG=OFF -DENABLE_VORONOI=OFF -DENABLE_LATTE=OFF -DENABLE_PYTHON=OFF -DENABLE_USER-MEAMC=ON -DENABLE_USER-PHONON=ON -DENABLE_GZIP=ON
# make 
cp lmp_serial $PREFIX/bin/lmp_serial
# MPI version are only compiled for Linux 
if [ $OSX_ARCH != "i386" ] && [ $OSX_ARCH != "x86_64" ]
then
    # cmake ./cmake -DENABLE_ASPHERE=ON -DENABLE_BODY=ON -DENABLE_CLASS2=ON -DENABLE_COLLOID=ON -DENABLE_COMPRESS=ON -DENABLE_CORESHELL=ON -DENABLE_DIPOLE=ON -DENABLE_GRANULAR=ON -DENABLE_KSPACE=ON -DENABLE_MANYBODY=ON -DENABLE_MC=ON -DENABLE_MEAM=ON -DENABLE_MISC=ON -DENABLE_MOLECULE=ON -DENABLE_PERI=ON -DENABLE_REAX=ON -DENABLE_REPLICA=ON -DENABLE_RIGID=ON -DENABLE_SHOCK=ON -DENABLE_SNAP=ON -DENABLE_SRD=ON -DENABLE_OPT=ON -DENABLE_KIM=OFF -DENABLE_GPU=OFF -DENABLE_KOKKOS=OFF -DENABLE_MPIIO=OFF -DENABLE_MSCG=OFF -DENABLE_VORONOI=OFF -DENABLE_LATTE=OFF -DENABLE_PYTHON=OFF -DENABLE_USER-MEAMC=ON -DENABLE_USER-PHONON=ON -DENABLE_GZIP=ON -DBUILD_MPI=ON
    # make
    make mpi LMP_INC="-DLAMMPS_EXCEPTIONS"
    cp lmp_mpi $PREFIX/bin/lmp_mpi
fi
# cmake ./cmake -DENABLE_ASPHERE=ON -DENABLE_BODY=ON -DENABLE_CLASS2=ON -DENABLE_COLLOID=ON -DENABLE_COMPRESS=ON -DENABLE_CORESHELL=ON -DENABLE_DIPOLE=ON -DENABLE_GRANULAR=ON -DENABLE_KSPACE=ON -DENABLE_MANYBODY=ON -DENABLE_MC=ON -DENABLE_MEAM=ON -DENABLE_MISC=ON -DENABLE_MOLECULE=ON -DENABLE_PERI=ON -DENABLE_REAX=ON -DENABLE_REPLICA=ON -DENABLE_RIGID=ON -DENABLE_SHOCK=ON -DENABLE_SNAP=ON -DENABLE_SRD=ON -DENABLE_OPT=ON -DENABLE_KIM=OFF -DENABLE_GPU=OFF -DENABLE_KOKKOS=OFF -DENABLE_MPIIO=OFF -DENABLE_MSCG=OFF -DENABLE_VORONOI=OFF -DENABLE_LATTE=OFF -DENABLE_PYTHON=OFF -DENABLE_USER-MEAMC=ON -DENABLE_USER-PHONON=ON -DENABLE_GZIP=ON -DBUILD_SHARED_LIBS=ON
# make
make serial mode=shlib LMP_INC="-DLAMMPS_EXCEPTIONS"
cd ../python
python install.py
