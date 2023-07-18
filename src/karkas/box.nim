import karax/[kbase, vdom, vstyles]


type
  Box* = ref object of VNode
    flex* = 0
    customStyle*: VStyle


proc render*(self: Box, body: VNode): VNode =
  result = newVNode(VNodeKind.tdiv) 

  let
    flexStyle = style {StyleAttr.flex: kstring $self.flex}
    customStyle =
      if not self.customStyle.isNil:
        self.customStyle
      else:
        style()

  result.style = flexStyle.merge(customStyle)

  for node in body: 
    result.add(node)


proc boxStyle*(size = 0): VStyle =
 style {StyleAttr.flex: kstring $size}

