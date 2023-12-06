# LibeventPlus

## About

A simple C++ wrapper for the Libevent portable polling solution. Only basic Libevent functionality has been included to meet personal requirements.

### How to use

Most function names have been kept close to their Libevent counterparts.

An EventBase is instantiated, and from this its member function new_event() creates Events for its underlying base. Events can then access related event functions, such as adding, removing & setting priority.

### References

Use of this library should be guided, if not entirely informed, by the official Libevent docs: https://libevent.org/libevent-book/