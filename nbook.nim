import nimibook


var book = initBookWithToc:
  entry("Welcome to Karkas!", "index.nim")
  section("Tutorial", "tutorial.nim"):
    entry("Basics", "tutorial/basics.nim")
    entry("Forms", "tutorial/forms.nim")
    entry("Layouts", "tutorial/layouts.nim")
  entry("Changelog", "changelog.nim")
 

nimibookCli(book)

