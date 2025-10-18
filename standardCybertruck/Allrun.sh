#!/bin/bash

# This is a blockMesh generation, a 4 processor in parallel snappHexMesh with overwrite
# process and a 4 processor in parallel foamRun

blockMesh >log.blockMesh

if grep -q "End" log.blockMesh; then
    echo "blockMesh completed successfully. ✅"
else
    echo "blockMesh failed. Check log.blockMesh for details. ❌"
    exit 1
fi

decomposePar >log.decomposePar

if grep -q "End" log.decomposePar; then
    echo "decomposePar completed successfully. ✅"
else
    echo "decomposePar failed. Check log.decomposePar for details. ❌"
    exit 1
fi

mpirun -np 4 snappyHexMesh -overwrite -parallel >log.snappyHexMesh 2>&1

echo "snappyHexMesh is running. This may take a while..."

if grep -q "End" log.snappyHexMesh; then
    echo "snappyHexMesh completed successfully. ✅"
else
    echo "snappyHexMesh failed. Check log.snappyHexMesh for details. ❌"
    exit 1
fi

reconstructPar >log.reconstructPar

if grep -q "End" log.reconstructPar; then
    echo "reconstructPar completed successfully. ✅"
else
    echo "reconstructPar failed. Check log.reconstructPar for details. ❌"
    exit 1
fi

checkMesh >log.checkMesh

if grep -q "End" log.checkMesh; then
    echo "checkMesh completed successfully. ✅"
else
    echo "checkMesh failed. Check log.checkMesh for details. ❌"
    exit 1
fi

mpirun -np 4 foamRun -parallel >log.foamRun 2>&1 &

echo "foamRun is running. This may take a while... Monitor the process using Time output:"

tail -f log.foamRun | egrep ^Time
