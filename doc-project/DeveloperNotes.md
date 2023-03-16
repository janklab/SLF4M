# slf4m-jankalog developer notes

These are developer notes for the slf4m-jankalog project, mostly for Andrew's own use while working on it and getting it to build. Notes on this project are spread between the local notes files in this directory, the [slf4m-jankalog GitHub Issues](https://github.com/janklab/slf4m-jankalog/issues), and this []"R2021a+ / log4j 2.x compatibility" issue](https://github.com/janklab/SLF4M/issues/15) on [SLF4M](https://github.com/janklab/SLF4M)'s GitHub.

Most of the work here has been in getting the original releases to just build in the "modern" Java world. A big part of that has been Maven 3: the projects were originally built using Maven 2, and Maven 2 basically doesn't work any more, because some of the network services it depends on have been turned off, and it's hard to get installed on contemporary macOS in the first place.

## Repo organization

* slf4m-jankalog/
  * doc-project/ - Internal documentation for slf4m-jankalog hackers.
  * src/
    * opp-orig/ - Pristine, unmodified sources from the original upstream releases.
    * opp-modern/ - Modifications just to get upstream releases to build in the 2022 Java environment.
    * opp-munged/ - Renamed packages for side-by-side loading.

The opp-munged code is the final goal of this project, with the package names modified so they can be loaded side-by-side in a single Java process with other versions of SLF4J and Log4j, like Matlab R2021a. The opp-munged code is based on opp-modern. Opp-modern leaves all the package names as is, and updates the build and packaging stuff, plus minimal modifications to the actual code, to get it building and usable in the 2022 world's Java ecosystem. Opp-modern is a prerequisite for opp-munged.

As of 2023-03-01, I'm still working on getting the opp-modern code building, and haven't gotten to doing the opp-munged stuff yet, so the opp-munged directory is empty.

## Log4j notes

### Maven Plugin References

I don't know why it's so hard to find the reference doco for Maven plugins' `<configuration>` options on the <https://maven.apache.org> web site! So I'm keeping a list of them for individual plugins here.

### Maven Plugin Configuration References

* [`surefire` (tests and JUnit)](https://maven.apache.org/surefire/maven-surefire-plugin/test-mojo.html)
* [`compiler`](https://maven.apache.org/components/plugins/maven-compiler-plugin/compile-mojo.html)
* [`antrun`](https://maven.apache.org/plugins/maven-antrun-plugin/run-mojo.html)
* [`assembly`](https://maven.apache.org/plugins-archives/maven-assembly-plugin-2.6/assembly-mojo.html)
  * and [`assembly`'s main page](https://maven.apache.org/plugins/maven-assembly-plugin/assembly.html), atypically, has an XML element reference, but I think that's for their "assembly" file or element model, not the `<configuration>` stuff.
  * For v3.4.2, it has [a "single-mojo.html" page](https://maven.apache.org/plugins/maven-assembly-plugin/single-mojo.html)

So, the URL patterns don't seem uniform, but it looks like they always say `-mojo.html`, so you can google for `<plugin_name> mojo` and find that page?

### Miscellaneous references

* [Running surefire JUnit tests silently](https://rieckpil.de/run-java-tests-with-maven-silently-only-log-on-failure)
