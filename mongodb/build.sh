#!/bin/bash

APPNAME=mongodb
VERSION=5.0.5

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

# ./configure
# patch Makefile < ../patches/Makefile.patch
# make

popd > /dev/null 2>&1 || exit 1

cp ${DIRNAME}/mongodb .

rm -rf ${DIRNAME}
rm -rf ${ARCHIVE}

echo -n "Build complete!"
