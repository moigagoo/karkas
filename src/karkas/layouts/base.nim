import karax/[karax, karaxdsl, kbase, vdom, vstyles]

import ../pages
import ../components/hbox
import ../components/box
import ../components/toppanel
import ../components/navbar


var
  counter = 0
  f = "0"
  panel1 = HBox()
  panel2 = HBox(direction: Direction.rightToLeft)
  panel3 = HBox(style: style {background: kstring"red"})
  panel4 = TopPanel(direction: Direction.rightToLeft, style: style {background: kstring"lightblue"})
  nav = NavBar(sticky: true)

panel4.events = @{
  onclick: proc(event: Event, target: VNode) {.closure.} =
    inc counter
    panel2.direction =
      if panel2.direction == leftToRight: rightToLeft
      else: leftToRight
    f = if f == "0": "1" else: "0"
    redraw(),
  onmouseenter: proc(event: Event, target: VNode) {.closure.} =
    panel4.style = panel4.style.merge(style {height: kstring"50px"})
    redraw(),
  onmouseleave: proc(event: Event, target: VNode) {.closure.} =
    panel4.style = panel4.style.merge(style {height: kstring ""})
    redraw(),
}

nav.entries = @[
  NavEntry(title: "Home", url: "#/", internal: true, page: Page.index),
  NavEntry(title: "About us", url: "#/about/", internal: true, page: Page.about),
  NavEntry(title: "External", url: "https://nim-lang.org", internal: false)
]


proc render*(bodyWrapper: VNode): VNode =
  buildHtml:
    tdiv:
      nav.render()
      panel1.render buildHtml(tdiv) do:
        for entry in ["One", "Two"]:
          let b = Box(flex: f)
          b.render buildHtml(tdiv) do:
            tdiv(style = {padding: "10px"}):
              text entry
      panel2.render buildHtml(tdiv) do:
        for entry in ["Three", "Four"]:
          tdiv(style = {padding: "10px"}):
            text entry
      panel3.render buildHtml(tdiv) do:
        for entry in ["Five", "Six"]:
          tdiv(style = {padding: "10px"}):
            text entry
      panel4.render buildHtml(tdiv) do:
        for entry in ["Seven", "Eight"]:
          tdiv(style = {padding: "10px"}):
            text entry
      tdiv:
        h1: text $counter
        for node in bodyWrapper: 
          node

