# SLF4M Release Checklist

* Double-check the version number in `VERSION`
* CURRENTLY UNUSED: Update the installation instructions in README to use the upcoming new release tarball URL.
  * Format is: `https://github.com/janklab/SLF4M/releases/download/v<version>/SLF4M-<version>.tar.gz`
* Commit all the files changed by the above steps.
  * Use form: `git commit -a -m "Cut release v<version>"`
* Make sure your repo is clean: `git status` should show no local changes.
* Create a git tag and push it and the changes to GitHub.
  * `git tag v<version>`
  * `git push; git push --tags`
* Create a new GitHub release from the tag.
  * Just use `<version>` as the name for the release.
* Open development for next version
  * Update version number in `VERSION` to have a "+" suffix
  * `git commit -a -m 'Open development for next version'; git push`

* If there were any problems following these instructions exactly as written, report it as a bug.
