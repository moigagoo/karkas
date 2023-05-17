import karax/[karaxdsl, kbase, vdom, vstyles]
import karkas/components/[toppanel, bottompanel, vbox]

import components/naventry


var
  navbar = TopPanel(sticky: true, style: style {background: kstring"white", boxShadow: kstring"0 10px 10px lightgray"})
  homeEntry = NavEntry(title: "Home", url: "#/", internal: true, page: Page.index)
  aboutEntry = NavEntry(title: "About", url: "#/about/", internal: true, page: Page.about)
  nimEntry = NavEntry(title: "Nim ⬏", url: "https://nim-lang.org", internal: false)
  footer = BottomPanel(style: style {background: kstring"lightgray", height: kstring"200px"})


proc render*(bodyWrapper: VNode): VNode =
  buildHtml:
    tdiv:
      navbar.render buildHtml(tdiv) do:
        homeEntry.render()
        aboutEntry.render()
        nimEntry.render()
      main:
        for node in bodyWrapper:
          node
      footer. render buildHtml(tdiv) do:
        var
          col1 = VBox()
          col2 = VBox()

        col1.render buildHtml(tdiv) do:
          homeEntry.render()
          aboutEntry.render()

        col2.render buildHtml(tdiv) do:
          nimEntry.render()

