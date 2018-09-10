<h1><img src="resources/icon.png"/> woff2</h1>

latest github.com/google/woff2 compiled with Cygwin under Windows, so you have exe. 
Binary included, ready to use. 

<pre>
woff2
binary
download
cygwin
built
build
prebuilt
ready-to-use
</pre>

<br/>

<hr/>

# woff2-prebuild
latest github.com/google/woff2 compiled with Cygwin under Windows, so you have exe. Binary included, ready to use.
include source and brotli, flat (no modules)

if you want to run it outside of Cygwin (like.. normal windows..) you should use the files in `Cygwin runtimes` folder.

<pre>
This is a README for the font compression reference code. There are several
compression related modules in this repository.

brotli/ contains reference code for the Brotli byte-level compression
algorithm. Note that it is licensed under the MIT license.

src/ contains the C++ code for compressing and decompressing fonts.

# Build & Run

This document documents how to run the compression reference code. At this
writing, the code, while it is intended to produce a bytestream that can be
reconstructed into a working font, the reference decompression code is not
done, and the exact format of that bytestream is subject to change.

The build process depends on the g++ compiler.

## Build

On a standard Unix-style environment:

<pre>
git clone --recursive https://github.com/google/woff2.git
cd woff2
make clean all
</pre>

Alternatively, if Brotli is already installed on your system you can use CMake
to build executables and libraries:

<pre>
git clone https://github.com/google/woff2.git
cd woff2
mkdir out
cd out
cmake ..
make
make install
</pre>

By default, shared libraries are built. To use static linkage, do:

<pre>
cd woff2
mkdir out-static
cmake -DBUILD_SHARED_LIBS=OFF ..
make
make install
</pre>

## Run

Ensure the binaries from the build process are in your $PATH, then:

<pre>
woff2_compress myfont.ttf
woff2_decompress myfont.woff2
</pre>

# References

http://www.w3.org/TR/WOFF2/
http://www.w3.org/Submission/MTX/

Also please refer to documents (currently Google Docs):

WOFF Ultra Condensed file format: proposals and discussion of wire format
issues (PDF is in docs/ directory)

WIFF Ultra Condensed: more discussion of results and compression techniques.
This tool was used to prepare the data in that document.
</pre>