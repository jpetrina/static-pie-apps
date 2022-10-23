#!/bin/bash

APPNAME=bzip2
VERSION=1.0.8
DIRNAME=${APPNAME}-${VERSION}
ARCHIVE=${DIRNAME}.tar.gz
URL=https://sourceware.org/pub/${APPNAME}/${APPNAME}-${VERSION}.tar.gz

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
echo -n "Unpacking bzip2 ... "
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

./configure
# patch Makefile < ../patches/Makefile.patch
make

popd > /dev/null 2>&1 || exit 1

cp ${DIRNAME}/bzip2 .

rm -rf ${DIRNAME}
rm -rf ${ARCHIVE}

echo -n "Build complete!"
