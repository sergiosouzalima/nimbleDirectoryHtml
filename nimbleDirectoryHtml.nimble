# Package

version       = "0.1.0"
author        = "Sergio Lima"
description   = "Nimble Package Directory XML to HTML"
license       = "MIT"
srcDir        = "src"
bin           = @["nimbleDirectoryHtml"]


# Dependencies

requires "nim >= 1.6.6"
requires httpClient
requires xml
requires xml/selector
requires strutils