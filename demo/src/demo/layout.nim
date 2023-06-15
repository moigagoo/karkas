import karax/[karaxdsl, kbase, vdom, vstyles]
import karkas/layout/[toppanel, bottompanel, vbox, floatingbox, hbox, box]

import state
import components/[naventry, notification]


var
  navbar = TopPanel(sticky: true, style: style {background: kstring"white", boxShadow: kstring"0 10px 10px lightgray"})
  leftBox = HBox(flex: "3")
  spacer = Box(flex: "5")
  rightBox = HBox(flex: "2", direction: HDirection.rightToLeft)
  homeEntry = NavEntry(title: "Home", url: "#/", internal: true, page: Page.index)
  aboutEntry = NavEntry(title: "About", url: "#/about/", internal: true, page: Page.about)
  nimEntry = NavEntry(title: "Nim ⬏", url: "https://nim-lang.org", internal: false)
  footer = BottomPanel(style: style {background: kstring"lightgray", height: kstring"200px"})
  notificationBox = FloatingBox(hPosition: HPosition.center, direction: VDirection.bottomToTop)


proc render*(bodyWrapper: VNode): VNode =
  buildHtml:
    tdiv:
      navbar.render buildHtml(tdiv) do:
        leftBox.render buildHtml(tdiv) do:
          homeEntry.render()
          aboutEntry.render()
        spacer.render buildHtml(tdiv) do:
          tdiv()
        rightBox.render buildHtml(tdiv) do:
          nimEntry.render()
      main:
        for node in bodyWrapper:
          node
      footer.render buildHtml(tdiv) do:
        var
          col1 = VBox()
          col2 = VBox()

        col1.render buildHtml(tdiv) do:
          homeEntry.render()
          aboutEntry.render()

        col2.render buildHtml(tdiv) do:
          nimEntry.render()
      notificationBox.render buildHtml(tdiv) do:
        for r in state.notifications:
          let n = r[]
          n.render()

