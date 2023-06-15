import karax/[kbase, vdom, vstyles]

import box


type
  Super = Box
  HDirection* = enum
    leftToRight, rightToLeft
  HBox* = object of Super
    direction* = HDirection.leftToRight


proc render*(self: HBox, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {StyleAttr.display: kstring"flex"}
    directionStyle = case self.direction
      of HDirection.leftToRight: style {StyleAttr.flexDirection: kstring"row"}
      of HDirection.rightToLeft: style {StyleAttr.flexDirection: kstring"row-reverse"}
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(directionStyle).merge(customStyle)

  var
    super = Super(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

