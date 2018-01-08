#!/bin/bash

TREZOR_GIT_URL=git://github.com/trezor/python-trezor.git
KEEPKEY_GIT_URL=git://github.com/keepkey/python-keepkey.git
BTCHIP_GIT_URL=git://github.com/LedgerHQ/btchip-python.git

BRANCH=master

# These settings probably don't need any change

PYHOME=/c/python27
PYTHON="$PYHOME/python.exe"

# Let's begin!
cd ~/AppData/Local/Temp/zcl

# Install Cython
$PYTHON -m pip install setuptools --upgrade
$PYTHON -m pip install cython
$PYTHON -m pip install trezor==0.7.16
$PYTHON -m pip install keepkey
$PYTHON -m pip install btchip-python

#git clone https://github.com/trezor/cython-hidapi.git
#replace: from distutils.core import setup, Extenstion
#cd cython-hidapi
#git submodule init
#git submodule update
#$PYTHON setup.py install
#cd ..


