import karax/[kbase, vdom, vstyles]

import component


type
  Direction* = enum
    topToBottom, bottomToTop
  VBox* = object of Component
    direction* = Direction.topToBottom


proc render*(self: VBox, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {display: kstring"flex"}
    directionStyle = case self.direction
      of Direction.topToBottom: style {flexDirection: kstring"column"}
      of Direction.bottomToTop: style {flexDirection: kstring"column-reverse"}
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(directionStyle).merge(customStyle)

  var
    super = Component(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

