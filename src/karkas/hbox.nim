import karax/[kbase, vdom, vstyles]

import component


type
  Direction* = enum
    leftToRight, rightToLeft
  HBox* = object of Component
    direction* = Direction.leftToRight


proc render*(self: HBox, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {display: kstring"flex"}
    directionStyle = case self.direction
      of Direction.leftToRight: style {flexDirection: kstring"row"}
      of Direction.rightToLeft: style {flexDirection: kstring"row-reverse"}
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

