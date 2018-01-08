#!/bin/bash

# You probably need to update only this link
ELECTRUM_GIT_URL=https://github.com/BTCP-community/electrum-zcl.git
BRANCH=master
NAME_ROOT=electrum-zcl

# These settings probably don't need any change
PYHOME=/c/python27
PYTHON="$PYHOME/python.exe -OO -B"


# Let's begin!
cd ~/AppData/Local/Temp/zcl

if [ -d "electrum-zcl-git" ]; then
    # GIT repository found, update it
    echo "Pull"
    cd electrum-zcl-git
    git checkout $BRANCH
    git pull
    cd ..
else
    # GIT repository not found, clone it
    echo "Clone"
    git clone -b $BRANCH $ELECTRUM_GIT_URL electrum-zcl-git
fi

cd electrum-zcl-git
VERSION=`git describe --tags`
echo "Last commit: $VERSION"

cd ..

rm -rf /c/electrum-zcl
cp -r electrum-zcl-git /c/electrum-zcl
cp electrum-zcl-git/LICENCE .

# add python packages (built with make_packages) RUN make_packages?
##cp -r ../../../packages $WINEPREFIX/drive_c/electrum-zcl/

# add locale dir
##cp -r ../../../lib/locale $WINEPREFIX/drive_c/electrum-zcl/lib/

## FROM ORIGINAL, added first time
##curl -o electrum-zcl-git/contrib/requirements.txt https://raw.githubusercontent.com/spesmilo/electrum/master/contrib/requirements.txt
##python -m pip install -r electrum-zcl-git/contrib/requirements.txt


# Build Qt resources
/c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe /c/electrum-zcl/icons.qrc -o /c/electrum-zcl/lib/icons_rc.py
/c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe /c/electrum-zcl/icons.qrc -o /c/electrum-zcl/gui/qt/icons_rc.py
/c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe /c/electrum-zcl/icons.qrc -o /c/electrum-zcl/lib/icons_rc.py
/c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe /c/electrum-zcl/icons.qrc -o /c/electrum-zcl/gui/zcl/icons_rc.py
/c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe /c/electrum-zcl/style.qrc -o /c/electrum-zcl/lib/style_rc.py
/c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe /c/electrum-zcl/style.qrc -o /c/electrum-zcl/gui/zcl/style_rc.py

pushd /c/electrum-zcl
python setup.py install
popd

## delete any old build
rm -rf dist/
rm -rf build/

# build standalone version
$PYTHON -m PyInstaller --noconfirm --ascii --name $NAME_ROOT-$VERSION.exe -w electrum-zcl-git/contrib/build-wine/deterministic.spec

# build NSIS installer
# $VERSION could be passed to the electrum.nsi script, but this would require some rewriting in the script iself.
"/c/Program Files (x86)/NSIS/makensis.exe" /DPRODUCT_VERSION=$VERSION electrum.nsi

cd dist
mv electrum-zcl-setup.exe $NAME_ROOT-$VERSION-setup.exe
cd ..

echo "Done."
