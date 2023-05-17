import karax/[kbase, vdom, vstyles]

import hbox


type
  BottomPanel* = object of HBox
    sticky* = false


proc render*(self: BottomPanel, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {bottom: kstring"0", width: kstring"100%"}
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

