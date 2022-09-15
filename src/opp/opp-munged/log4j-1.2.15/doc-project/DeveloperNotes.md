# slf4m-jankalog log4j notes

## Maven Plugin References

I don't know why it's so hard to find the reference doco for Maven plugins' `<configuration>` options on  the <https://maven.apache.org> web site! So I'm keeping a list of them for individual plugins here.

### Plugin Configuration References

* [`surefire` (tests and JUnit)](https://maven.apache.org/surefire/maven-surefire-plugin/test-mojo.html)
* [`compiler`](https://maven.apache.org/components/plugins/maven-compiler-plugin/compile-mojo.html)
* [`antrun`](https://maven.apache.org/plugins/maven-antrun-plugin/run-mojo.html)
* [`assembly`](https://maven.apache.org/plugins-archives/maven-assembly-plugin-2.6/assembly-mojo.html)
  * and [`assembly`'s main page](https://maven.apache.org/plugins/maven-assembly-plugin/assembly.html), atypically, has an XML element reference, but I think that's for their "assembly" file or element model, not the `<configuration>` stuff.
  * For v3.4.2, it has [a "single-mojo.html" page](https://maven.apache.org/plugins/maven-assembly-plugin/single-mojo.html)

So, the URL patterns don't seem uniform, but it looks like they always say `-mojo.html`, so you can google for `<plugin_name> mojo` and find that page?

### Miscellaneous references

* [Running surefire JUnit tests silently](https://rieckpil.de/run-java-tests-with-maven-silently-only-log-on-failure)
