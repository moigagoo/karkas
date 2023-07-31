import nimibook


var book = initBookWithToc:
  entry("Welcome to Karkas!", "index.nim")
  entry("Tutorial", "tutorial.nim")
  entry("Changelog", "changelog.nim")


nimibookCli(book)

