#!/bin/bash

APPNAME=mongodb
VERSION=6.0.1

DIRNAME=${APPNAME}-src-r${VERSION}
ARCHIVE=${DIRNAME}.tar.gz
URL=https://fastdl.mongodb.org/src/${APPNAME}-src-r${VERSION}.tar.gz

# Clean up
rm -rf ${ARCHIVE}
rm -rf ${DIRNAME}

echo -n "Downloading ${APPNAME} sources ... "
wget -q ${URL}
if test $? -ne 0; then
    echo ""
    echo "Unable to download ${APPNAME} from ${URL}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Unpacking mongodb ... "
tar -xvf ${ARCHIVE}
if test $? -ne 0; then
    echo ""
    echo "Unable to extract ${APPNAME}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Building ${APPNAME} ... "
pushd ${DIRNAME} > /dev/null 2>&1 || exit 1

for file in ../patches/*.patch; do
echo "Applying patch $file..."
	patch -Np1 -i $file
done

_scons_args=(
  --use-system-pcre
  --use-system-snappy
  --use-system-yaml
  --use-system-zlib
  # --use-system-openssl
  --use-system-stemmer
  --use-sasl-client
  --ssl=off
  --disable-warnings-as-errors
  --use-system-boost    # Doesn't compile
  --use-system-zstd
  --runtime-hardening=off
)
export CFLAGS="-pipe -fno-plt -static-pie"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now"
export SCONSFLAGS="-j$(nproc) -l$(nproc)"
./buildscripts/scons.py install-devcore "${_scons_args[@]}"

popd > /dev/null 2>&1 || exit 1

# cp ${DIRNAME}/mongodb .

# rm -rf ${DIRNAME}
# rm -rf ${ARCHIVE}

echo -n "Build complete!"
