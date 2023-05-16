import karax/[karaxdsl, kbase, vdom, vstyles]
import karkas/components/[box, toppanel, bottompanel, vbox]

import pages, state


var
  navbar = TopPanel(sticky: true, style: style {background: kstring"white", boxShadow: kstring"0 10px 10px lightgray"})
  homeEntry = Box(style: style {padding: kstring"10px"})
  aboutEntry = Box(style: style {padding: kstring"10px"})
  nimEntry = Box(style: style {padding: kstring"10px"})
  footer = BottomPanel(style: style {background: kstring"lightgray", height: kstring"200px"})


proc render*(bodyWrapper: VNode): VNode =
  buildHtml:
    tdiv:
      navbar.render buildHtml(tdiv) do:
        homeEntry.render buildHtml(tdiv) do:
          if currentPage == Page.index:
            bold:
              text "Home"
          else:
            a(href = "#/"):
              text "Home"
        aboutEntry.render buildHtml(tdiv) do:
          if currentPage == Page.about:
            bold:
              text "About"
          else:
            a(href = "#/about/"):
              text "About"
        nimEntry.render buildHtml(tdiv) do:
          a(href = kstring"https://nim-lang.org", target = kstring"_blank"):
            text "Nim ⬏"
      main:
        for node in bodyWrapper:
          node
      footer. render buildHtml(tdiv) do:
        var col = VBox()
        col.render buildHtml(tdiv) do:
          tdiv: 
            text kstring"Foo"

