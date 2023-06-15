# Package

version       = "0.1.0"
author        = "Constantine Molchanov"
description   = "Component system and UI kit for Karax."
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.9.3"
requires "karax >= 1.2.3", "kraut >= 1.0.2"

taskRequires "serve", "nimhttpd >= 1.5.1"


# Tasks

task make, "Build the app":
  exec "karun src/karkas.nim"

task serve, "Serve the app with a local server":
  echo "The app is served at: http://localhost:1337/app.html#/"
  echo()
  exec "nimhttpd"

