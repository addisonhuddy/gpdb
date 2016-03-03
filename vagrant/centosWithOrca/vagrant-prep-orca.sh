#!/bin/bash

set -eux

export PATH=$PATH:/usr/local/bin:/usr/local

# Build GPOS
git clone https://github.com/greenplum-db/gpos.git
pushd gpos
  mkdir -p build
  pushd build
    cmake -D CMAKE_INSTALL_PREFIX=/usr/local/gpos ../
    make -j4
    sudo make install
  popd
popd

# Clone GPORCA
git clone https://github.com/greenplum-db/gporca.git

# wget xerces
git clone https://github.com/xinzweb/gp-xerces.git

# Install xerces
pushd gp-xerces
  mkdir -p build
  pushd build
    ../configure
    make
    sudo make install
  popd
popd

# Build GPORCA

pushd gporca
  mkdir -p build
  pushd build
    cmake -D GPOS_INCLUDE_DIR=/usr/local/gpos/include \
          -D GPOS_LIBRARY=/usr/local/gpos/libgpos.so \
          -D CMAKE_INSTALL_PREFIX=/usr/local/gporca \
          ../
    make -j4
    sudo make install
  popd
popd

# Done, let GPDB do its thing and build with --enable-orca
