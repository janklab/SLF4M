Dispstr Developer Notes
========================

##  Design Concerns

###  Packages

The Dispstr functions are implemented as global functions, with no namespace. Usually I stick library functions in a package to avoid cluttering the global namespace. But that won't work here, because `dispstr()`, `dispstrs()`, and `prettyprint()` need to be overridden by classes' methods, and functions in packages cannot be overridden by methods.

The `dispstr.internal` package is for internal-use only stuff, and is not part of the public Dispstr API.
