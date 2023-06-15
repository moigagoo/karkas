import karax/[kbase, vdom, vstyles]

import box


type
  Super = Box
  VDirection* = enum
    topToBottom, bottomToTop
  VBox* = object of Super
    direction* = VDirection.topToBottom


proc render*(self: VBox, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {StyleAttr.display: kstring"flex"}
    directionStyle = case self.direction
      of VDirection.topToBottom: style {StyleAttr.flexDirection: kstring"column"}
      of VDirection.bottomToTop: style {StyleAttr.flexDirection: kstring"column-reverse"}
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

