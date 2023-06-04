import karax/[kbase, vdom, vstyles]

import vbox


type
  VPosition* = enum
    top, bottom
  HPosition* = enum
    right, left, center
  FloatingBox* = object of VBox
    vPosition* = VPosition.top
    hPosition* = HPosition.right


proc render*(self: FloatingBox, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style {position: kstring"fixed", width: kstring"20%"}
    vPositionStyle = case self.vPosition
      of VPosition.top:
        style {StyleAttr.top: kstring"0"}
      of VPosition.bottom:
        style {StyleAttr.bottom: kstring"0"}
    hPositionStyle = case self.hPosition
      of HPosition.right:
        style {StyleAttr.right: kstring"0"}
      of HPosition.left:
        style {StyleAttr.left: kstring"0"}
      of HPosition.center:
        style {StyleAttr.left: kstring"50%", StyleAttr.transform: kstring"translateX(-50%)"}
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(vPositionStyle).merge(hPositionStyle).merge(customStyle)

  var
    super = VBox(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

