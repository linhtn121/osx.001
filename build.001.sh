#!/bin/bash
export PATH=/usr/local/opt/qt/bin/bin/:$PATH

#export OPENSSL_ROOT_DIR=/Users/mac/openssl-1.1.1b

# Cleanup
cd ~
sudo rm -rf build-mac
#sudo rm -rf desktop
sudo rm -rf /Users/builder/install

# Clone the desktop client code
#git clone --recursive https://github.com/nextcloud/desktop.git
#cd desktop
#git checkout v2.5.2
#git submodule update --recursive

# Build qtkeychain
#cd ~/client/src/3rdparty/
#git clone https://github.com/frankosterfeld/qtkeychain.git
#cd qtkeychain
#git checkout v0.8.0
#cmake -DCMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_INSTALL_PREFIX=/Users/builder/install -DCMAKE_PREFIX_PATH=/usr/local/Cellar/qt/5.12.3 .
#sudo make -j1 install

# Build the client
cd ~
cp /Users/mac/Documents/client_theming-master/osx/dsa_pub.pem desktop/admin/osx/sparkle/
rm -rf build-mac
mkdir build-mac
cd build-mac
cmake -DCMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 -DCMAKE_INSTALL_PREFIX=/Users/builder/install -DCMAKE_PREFIX_PATH=/usr/local/Cellar/qt/5.12.3 -D SPARKLE_INCLUDE_DIR=~/Library/Sparkle.framework/ -D SPARKLE_LIBRARY=~/Library/Sparkle.framework/ -D OEM_THEME_DIR_=/Users/mac/Documents/client_theming-master/nextcloudtheme -DWITH_CRASHREPORTER=OFF -DNO_SHIBBOLETH=1 -DMIRALL_VERSION_BUILD=1 ../desktop
make -j2


#step 3
macdeployqt /Users/mac/build-mac/bin/nextcloud.app


#sudo make -j1 install
# The magic string here is SHA1 hash of your Developer ID Application certificate


#sudo ~/client/admin/osx/sign_app.sh /Users/builder/install/nextcloud.app 59A99DCCD0F91FB190706A1385F70877B54683DA
# The magic string here is SHA1 hash of your Developer ID Installer certificate
#sudo ~/build-mac/admin/osx/create_mac.sh /Users/builder/install ~/build-mac B201872B542F49F159EA9590124201762B7A46D7

# Generate a sparkle signature for the tbz
#openssl dgst -sha1 -binary < ~/install/*.tbz | openssl dgst -dss1 -sign ~/dsa_priv.pem | openssl enc -base64 > ~/sig.txt
#sudo mv ~/sig.txt ~/install/signature.txt
