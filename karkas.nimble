# Package

version       = "1.0.0"
author        = "Constantine Molchanov"
description   = "Layout helpers and sugar for Karax"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 2.0.0"
requires "karax >= 1.3.0"

taskRequires "setupBook", "nimib >= 0.3.8", "nimibook >= 0.3.1"


# Tasks

task setupBook, "Compiles the nimibook CLI-binary used for generating the docs":
  exec "nim c -d:release nbook.nim"

before book:
  rmDir "docs"
  exec "nimble setupBook"

task book, "Generate book":
  exec "./nbook".toExe & " --mm:orc --deepcopy:on update"
  exec "./nbook".toExe & " --mm:orc --deepcopy:on build"

after book:
  cpFile("CNAME", "docs/CNAME")

before docs:
  rmDir "docs/apidocs"

task docs, "Generate docs":
  exec "nimble doc --outdir:docs/apidocs --project --index:on src/karkas"

