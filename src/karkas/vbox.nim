import karax/[kbase, vdom, vstyles]

import box


type
  VDirection* = enum
    topToBottom, bottomToTop
  VBox* = object of Box
    direction* = VDirection.topToBottom


proc render*(self: VBox, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {display: kstring"flex"}
    directionStyle = case self.direction
      of VDirection.topToBottom: style {flexDirection: kstring"column"}
      of VDirection.bottomToTop: style {flexDirection: kstring"column-reverse"}
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(directionStyle).merge(customStyle)

  var
    super = Box(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

