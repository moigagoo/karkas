import karax/[karaxdsl, kbase, vdom, vstyles]

import box, toppanel
import ../pages
import ../state


type
  NavEntry* = object of RootObj
    title*: string
    url*: string
    case internal* = true
    of true:
      page*: Page
    of false:
      discard
  NavBar* = object of TopPanel
    entries*: seq[NavEntry]


proc render*(self: NavBar): VNode =
  let
    defaultStyle = style {background: kstring"white", boxShadow: kstring"0 10px 10px lightgray"}
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(customStyle)

  let bodyWrapper = buildHtml(tdiv):
    for entry in self.entries:
      var entryBox = Box(style: style {padding: kstring"10px"}) 

      entryBox.render buildHtml(tdiv) do:
        if entry.internal and entry.page == state.currentPage:
          bold:
            text kstring entry.title
        else:
          a(href = kstring entry.url):
            text kstring entry.title

  var
    super = TopPanel(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

