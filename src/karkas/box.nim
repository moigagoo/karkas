import karax/[kbase, vdom, vstyles]

import component


type
  Box* = object of Component
    flex* = "0"


proc render*(self: Box, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style()
    flexStyle = style {StyleAttr.flex: kstring self.flex}
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(flexStyle).merge(customStyle)

  var
    super = Component(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

