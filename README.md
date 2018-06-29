# SwiftGit

## Use
* Run `carthage update --platform osx --cache-builds` to install dependencies, run the app

## Publishing on the AppStore
Although this is licensed as MIT software we would like to ask you to not to publish your copies on the AppStore as we would like to do it ourselves when the app is a wee bit more stable.

## Required Tools
To build SwiftGit2 (one of the SwiftGit dependencies), you'll need the following tools installed locally:

* cmake
* libssh2
* libtool
* autoconf
* automake
* pkg-config


## Potential issues
If you have `SwiftLint` installed you might have an issue compiling carthage thanks to `SwiftShell` not passing it's validation. You can remove SwiftLint temporarily using `brew uninstall swiftlint` and later adding it again. We should send a PR to the [kareman/SwiftShell](https://github.com/kareman/SwiftShell) unless one of you beats us to it!
