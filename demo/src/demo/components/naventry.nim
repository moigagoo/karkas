import karax/[karaxdsl, kbase, vdom, vstyles]

import karkas/components/box

import ../[pages, state]


export pages


type
  NavEntry* = object of Box
    title*, url*: string
    case internal* = false
    of true: 
      page*: Page
    of false:
      discard


proc render*(self: NavEntry): VNode =
  let
    active = self.internal and self.page == state.currentPage
    defaultStyle = style {margin: kstring"10px"}
    activeStyle =
      if active:
        style {fontWeight: kstring"bold"}
      else:
        style()
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(activeStyle).merge(customStyle)
    bodyWrapper = buildHtml(tdiv):
      if self.internal:
        if active:
          text kstring self.title
        else:
          a(href = kstring self.url):
            text kstring self.title
      else:
        a(href = kstring self.url, target = kstring"_blank"):
          text kstring self.title

  var
    super = Box(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

