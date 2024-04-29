#!/bin/bash

mkdir -p ~/source
cd ~/source
git clone --depth=1 -b lustre-fulldump https://github.com/algo74/ldms-fast-sample.git ldms

cd ldms
mkdir -p build
cd build
cat <<EOF > reconfig.sh
#!/bin/bash
set -xe
cd ..
./autogen.sh
cd build
../configure --prefix=/usr/local/ovis
EOF
chmod +x reconfig.sh