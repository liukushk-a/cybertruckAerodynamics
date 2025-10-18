#!/bin/bash

# This is a blockMesh generation, a 4 processor in parallel snappHexMesh with overwrite
# process and a 4 processor in parallel foamRun

blockMesh

decomposePar

mpirun -np 4 snappyHexMesh -overwrite -parallel >log.snappyHexMesh 2>&1 &

reconstructPar

checkMesh >log.checkMesh 2>&1 &

mpirun -np 4 foamRun -parallel >log.foamRun 2>&1 &

tail -f log.foamRun | egrep ^Time
