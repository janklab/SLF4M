# Notes on Janklab-munging of SFL4J 1.5.8

## Choices

Maven GroupId for these artifacts: net.janklab.shmorg.slf4j

(Like my log4j is net.janklab.opp.log4j, but I'll change that "opp" to "shmorg".)
Basically, "net.janklab.shmorg" is my replacement for the top-level "org". But "org.apache" in "org.apache.log4j" also becomes just "net.janklab.shmorg". I'm not sure if that's the right call.

Append `"-janklab.<n>"` to the versions, leaving the main version the same as upstream.

Build against log4j 1.2.15 for best compatibility with my munged versions.
