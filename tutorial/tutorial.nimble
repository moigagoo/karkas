# Package

version       = "0.1.0"
author        = "Constantine Molchanov"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["tutorial"]


# Dependencies

requires "nim >= 1.6.14"
requires "karax >= 1.2.3", "kraut >= 1.0.3"

taskRequires "serve", "static_server >= 2.2.1"


# Tasks

task make, "Build the app":
  exec "karun src/tutorial.nim"

task serve, "Serve the app with a local server":
  echo "The app is served at: http://localhost:1337/app.html#/"
  echo()
  exec "static_server"

