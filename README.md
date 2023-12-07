# LibeventPlus

## About

A simple C++ wrapper for the Libevent portable polling solution. Only basic Libevent functionality has been included to meet personal requirements.

### Installation

To install as a static library, either fork this repository or download the install script and identically named tar package in /build.

To install as a shared library (using CMake):

1. Download the *-Source.tar.gz package and unzip anywhere
2. From the command line, navigate to the build folder.
3. Execute the following line: `cmake --install .`
4. For UNIX, this will install to `/usr/local/libeventplus`. For WIN32, `c:/Program Files/libeventplus`

You should be able to include this in other CMake projects:
```cmake
find_package(Libevent REQUIRED)     # Required as a dependency but will not need to be linked
find_package(LibeventPlus)          # Link against this library 
```

### How to use

Most function names have been kept close to their Libevent counterparts.

An EventBase is instantiated, and from this its member function new_event() creates Events for its underlying base. Events can then access related event functions, such as adding, removing & setting priority.

### References

Use of this library should be guided, if not entirely informed, by the official Libevent docs: https://libevent.org/libevent-book/