#!/bin/sh

source ./0_append_distro_path.sh

extract_file pcre-8.41.tar

cd /c/temp/gcc
mv pcre-8.41 src
mkdir build dest
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-shared --enable-utf --enable-unicode-properties --enable-pcre16 --enable-pcre32 \
--enable-jit --enable-newline-is-anycrlf "CFLAGS=-s -O3" "CXXFLAGS=-s -O3" || fail_with pcre 1 - EPIC FAIL

make $X_MAKE_JOBS all || fail_with pcre 2 - EPIC FAIL
make install || fail_with pcre 3 - EPIC FAIL
cd /c/temp/gcc
rm -rf build src
mv dest pcre-8.41
cd pcre-8.41
rm -rf bin/pcre-config lib/pkgconfig lib/*.la share
cp include/pcreposix.h include/regex.h

7z -mx0 a ../pcre-8.41.7z *
