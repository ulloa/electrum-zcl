Electrum-ZCL - Lightweight ZClassic client
==========================================
Under Active Development - DO NOT RECEIVE MONEY. GEN'D ADDRESSES ARE STILL VTC. 
==========================================

::

  Licence: MIT Licence
  Original Author: Thomas Voegtlin
  Port Maintainer: Pooler (Electrum-LTC)
  Port Maintainer: Vertcoin (Electrum-VTC)
  Port Maintainer: Zclassic (Zclassic -ZCL)
  Language: Python
  Homepage: # 




Getting started
===============

Electrum is a pure python application.

If you downloaded the official package (tar.gz), you can run
Electrum from its root directory, without installing it on your
system; all the python dependencies are included in the 'packages'
directory. To run Electrum from its root directory, just do::

    ./electrum-zcl

You can also install Electrum on your system, by running this command::

    python setup.py install

This will download and install the Python dependencies used by
Electrum, instead of using the 'packages' directory.

If you cloned the git repository, you need to compile extra files
before you can run Electrum. Read the next section, "Development
Version".



Development version
===================


Check out the code from Github::

    git clone https://github.com/BTCP-community/electrum-zcl.git
    cd electrum-zcl

Grab setup dependencies::

    sudo apt-get install python-qt4 python-setuptools python-dev build-essential    sudo easy_install pip
    sudo pip2 install https://github.com/metalicjames/lyra2re-hash-python/archive/master.zip

Run install (this should install dependencies, you may need sudo)::

    python setup.py install

Compile the icons and style files for VTC::

    ARCHFLAGS="-arch i386 -arch x86_64"
    sudo apt-get install pyqt4-dev-tools

    pyrcc4 icons.qrc -o gui/zcl/icons_rc.py
    pyrcc4 style.qrc -o gui/zcl/style_rc.py

Compile the protobuf description file::

    sudo apt-get install protobuf-compiler
    protoc --proto_path=lib/ --python_out=lib/ lib/paymentrequest.proto

Create translations (optional)::

    sudo apt-get install python-pycurl gettext
    ./contrib/make_locale

And then run!::

    ./electrum-zcl


On Mac
===============
Install Homebrew ::

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)")


If on a Mac and some dependencies fail (PyQT4), you can also try:::
  brew install qt pyqt sip qscintilla2 
  brew install cartr/qt4/pyqt  


  mkdir -p ~/Library/Python/2.7/lib/python/site-packages

    echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth


    sudo pip2 install dnspython pyaes ecdsa requests six qrcode pbkdf2 google protobuf jsonrpclib PySocks vtc_scrypt blockchain

    sudo pip2 install https://github.com/metalicjames/lyra2re-hash-python/archive/master.zip

    echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

    sudo pip2 install dnspython pyaes ecdsa requests six qrcode pbkdf2 google protobuf jsonrpclib PySocks vtc_scrypt blockchain

    sudo pip2 install https://github.com/metalicjames/lyra2re-hash-python/archive/master.zip

   

Creating Binaries
=================


To create binaries, create the 'packages' directory::

    ./contrib/make_packages

This directory contains the python dependencies used by Electrum.
If you get ImportErrors, this is because the modules aren't installed or
are installed, but compressed. Uninstall/install dependencies with pip,
which always installs everything unzipped.

Mac OS X
--------
::

    # On MacPorts installs: 
    sudo python setup-release.py py2app
    
    # On Homebrew installs: 
    ARCHFLAGS="-arch i386 -arch x86_64" sudo python setup-release.py py2app --includes sip
    
    sudo hdiutil create -fs HFS+ -volname "Electrum-ZCL" -srcfolder dist/Electrum-ZCL.app dist/electrum-zcl-VERSION-macosx.dmg

Windows
-------

See `contrib/build-wine/README` file.


Android
-------

See `gui/kivy/Readme.txt` file.
