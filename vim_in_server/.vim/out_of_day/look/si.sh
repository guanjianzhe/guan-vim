#!/bin/bash
echo "Richard create lookup file "
cp ./lookup.sh ../
cd ../
./lookup.sh

echo "Richard create kernel source code tags..."
make -f ./look/kernel_tags SRCDIR=. ARCH=arm tags


