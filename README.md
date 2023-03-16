# SLF4M Jankalog - README

The Jankalog library is a collection of customized Java logging libraries to support [SLF4M](https://slf4m.janklab.net/). It is part of the [Janklab](https://janklab.net) suite of FLOSS libraries for Matlab.

These libraries are custom-modified forks of third-party open source logging libraries, which have been modified specifically to work with Matlab and SLF4M in various ways. The main way is to support the use of Log4j 1.x in Matlab R2021a and later, which ships with Log4j 2.x and the Log4j 1.x-2.x bridge and consumes the regular Log4j 1.x package & class namespace. (And SLF4M)

This is currently a work in progress (as of September 2022) and is not ready for use yet. Everything in here is preview, pre-beta quality, subject to change at any time, and is NOT SUPPORTED YET.

## WARNING: UNOFFICIAL, NONSTANDARD BUILDS

**THE LIBRARIES IN THIS PROJECT ARE NOT OFFICIAL OR REGULAR RELEASES OF LOG4J, SLF4J, OR WHATEVER UPSTREAM LIBRARIES THEY ARE FORKED FROM. THEY ARE SPECIAL "MUNGED" FORKED VERSIONS FOR USE WITH JANKLAB'S SLF4M LIBRARY.**

**THESE LIBRARIES WILL NOT WORK AS DROP-IN REPLACEMENTS FOR THE REGULAR, OFFICIAL VERSIONS OF THEM. THEIR PACKAGE NAMES HAVE BEEN CHANGED, AND THERE MAY BE OTHER CODE OR BEHAVIOR CHANGES.**

**PLEASE DO NOT CONTACT THE APACHE LOG4J OR SLF4J PROJECTS FOR SUPPORT WITH THIS PACKAGE. THEY WERE NOT INVOLVED IN ITS CREATION, ASIDE FROM BEING THE ORIGINAL CREATORS OF THE UPSTREAM CODE. (Thank you, Apache and SLF4J!)**

For more info, see: <https://github.com/janklab/SLF4M/issues/14>

## General Info

The libraries in this repo are only used by SLF4M. But they're in a separate repo, becuase they're a large enough effort in themselves that it's nice to keep them in their own repo for management purposes. The separate git commit histories make for easier reading, it's convenient to manage the CI settings and resources for the two areas independently, and it avoids inflating the size of the main SLF4M repo for developers who aren't working on the munged Log4j/SLF4J libraries (which is basically everyone, including Andrew most of the time.)

## License

The munged libraries are redistributed under the same license as their original upstream sources: MIT License for SLF4J and Apache License 2.0 for Log4j. Any code in this project not contained in those munged libraries is licensed under the Apache License 2.0.

## Contributing

The code in this repo is in and experimental, pre-alpha state. It is changing rapidly, including frequently rewriting the git commit history. For that reason, I'm not accepting pull requests at this point. If you have code changes or suggestions, please just write them up in an issue on GitHub.

## Author

Jankalog for SLF4M is developed by [Andrew Janke](https://apjanke.net). View [SLF4M's home page](https://slf4m.janklab.net) or get the code from [the repo on GitHub](https://github.com/janklab/slf4m-jankalog).

Coding for Jankalog was powered by [live Phish recordings](https://livephish.com) and Rachmaninoff.
