#!/bin/bash

# Please update these links carefully, some versions won't work under Wine
PYTHON_URL=https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi
PYQT4_URL=http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.1/PyQt4-4.11.1-gpl-Py2.7-Qt4.8.6-x32.exe
PYWIN32_URL=http://sourceforge.net/projects/pywin32/files/pywin32/Build%20219/pywin32-219.win32-py2.7.exe/download
#PYINSTALLER_URL=https://pypi.python.org/packages/source/P/PyInstaller/PyInstaller-2.1.zip
NSIS_URL=http://prdownloads.sourceforge.net/nsis/nsis-2.46-setup.exe?download
SETUPTOOLS_URL=https://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11.win32-py2.7.exe
LYRA2RE_HASH_PYTHON_URL=https://github.com/metalicjames/lyra2re-hash-python/archive/master.zip
## Added
MINGW_GET=http://downloads.sourceforge.net/project/mingw/Installer/mingw-get-setup.exe


PYHOME=/c/Python27

# Let's begin!
cd ~/AppData/Local/Temp

# Removing previous zcl
echo "creating zcl dir"
rm -rf zcl
mkdir zcl
echo "done"
cd zcl

# Install Python
curl -o python.msi "$PYTHON_URL"
### wget -O python.msi "$PYTHON_URL"
msiexec -q -i python.msi

# Install PyWin32
curl -L -o pywin32.exe "$PYWIN32_URL"
### wget -O pywin32.exe "$PYWIN32_URL"
./pywin32.exe

# Install PyQt4
curl -L -o PyQt.exe "$PYQT4_URL"
### wget -O PyQt.exe "$PYQT4_URL"
./PyQt.exe

echo 'export PATH="$PATH:/c/Python27"' > ~/.bashrc
export PATH="$PATH:/c/Python27"
$PYTHON=/c/Python27/python.exe

# Install ZBar
#wget -q -O zbar.exe "http://sourceforge.net/projects/zbar/files/zbar/0.10/zbar-0.10-setup.exe/download"
#wine zbar.exe

# install Cryptodome
$PYTHON -m pip install pycryptodomex

# install PySocks
$PYTHON -m pip install win_inet_pton

# install websocket (python2)
$PYTHON -m pip install websocket-client


# Install setuptools
#wget -O setuptools.exe "$SETUPTOOLS_URL"
#wine setuptools.exe

# Install NSIS installer
curl -L -o nsis.exe "$NSIS_URL"
### wget -q -O nsis.exe "$NSIS_URL"
./nsis.exe

# Install UPX
#wget -O upx.zip "http://upx.sourceforge.net/download/upx308w.zip"
#unzip -o upx.zip
#cp upx*/upx.exe .

# add dlls needed for pyinstaller, not using, pray it autofinds:
## cp $WINEPREFIX/drive_c/windows/system32/msvcp90.dll $WINEPREFIX/drive_c/Python27/
## cp $WINEPREFIX/drive_c/windows/system32/msvcm90.dll $WINEPREFIX/drive_c/Python27/


# Install MinGW
curl -L -O $MINGW_GET
### wget http://downloads.sourceforge.net/project/mingw/Installer/mingw-get-setup.exe
./mingw-get-setup.exe

echo "add c:\MinGW\bin to PATH using .bashrc"
echo 'export PATH="$PATH:/c/MinGW/bin"' >> ~/.bashrc
## echo "add c:\MinGW\bin to PATH using regedit"
## echo "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
## regedit

mingw-get.exe install gcc
mingw-get.exe install mingw-utils
mingw-get.exe install mingw32-libz

printf "[build]\ncompiler=mingw32\n" > $PYHOME/Lib/distutils/distutils.cfg

$PYTHON -m pip install vtc_scrypt
$PYTHON -m pip install win_inet_pton

$PYTHON -m pip install $LYRA2RE_HASH_PYTHON_URL
