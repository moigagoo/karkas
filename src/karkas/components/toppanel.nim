import karax/[kbase, vdom, vstyles]

import hbox


type
  TopPanel* = object of HBox
    sticky* = false


proc render*(self: TopPanel, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {top: kstring"0"}
    stickyStyle =
      if self.sticky:
        style {position: kstring"sticky"}
      else:
        style()
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(stickyStyle).merge(customStyle)

  var
    super = HBox(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

