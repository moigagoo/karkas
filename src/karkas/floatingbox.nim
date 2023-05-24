import karax/[kbase, vdom, vstyles]

import vbox


type
  VerticalPosition* = enum
    top, bottom
  HorizontalPosition* = enum
    right, left, center
  FloatingBox* = object of VBox
    verticalPosition* = VerticalPosition.top
    horizontalPosition* = HorizontalPosition.right


proc render*(self: FloatingBox, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {position: kstring"fixed", width: kstring"20%"}
    verticalPositionStyle = case self.verticalPosition
      of VerticalPosition.top:
        style {StyleAttr.top: kstring"0"}
      of VerticalPosition.bottom:
        style {StyleAttr.bottom: kstring"0"}
    horizontalPositionStyle = case self.horizontalPosition
      of HorizontalPosition.right:
        style {StyleAttr.right: kstring"0"}
      of HorizontalPosition.left:
        style {StyleAttr.left: kstring"0"}
      of HorizontalPosition.center:
        style {StyleAttr.left: kstring"50%", StyleAttr.transform: kstring"translateX(-50%)"}
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(verticalPositionStyle).merge(horizontalPositionStyle).merge(customStyle)

  var
    super = VBox(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

