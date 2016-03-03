#!/bin/bash

export PATH=$PATH:/usr/local/bin:/usr/local
sudo rm -rf /usr/local/greenplum-db
sudo mkdir /usr/local/greenplum-db
sudo chown -R vagrant:vagrant /usr/local/greenplum-db
cd /gpdb
./configure --enable-orca --prefix=/usr/local/greenplum-db --enable-depend --enable-debug --with-python || exit 1
sudo make clean || exit 1
sudo make || exit 1
sudo make install
sudo chown -R vagrant:vagrant /usr/local/greenplum-db

