# Package

version       = "0.1.0"
author        = "Constantine Molchanov"
description   = "Karkas demo."
license       = "MIT"
srcDir        = "src"
bin           = @["demo"]


# Dependencies

requires "nim >= 1.9.3"
requires "karax >= 1.2.3", "kraut >= 1.0.1"

taskRequires "serve", "static_server >= 2.2.1"


# Tasks

task make, "Build the app":
  let karun = findExe("karun")
  exec karun & " src/demo.nim"

task serve, "Serve the app with a local server":
  echo "The app is served at: http://localhost:1337/app.html#/"
  echo()
  exec findExe("static_server")

