import karax/[vdom, vstyles]


type
  Component* = object of RootObj
    vNodeKind* = VNodeKind.tdiv
    style*: VStyle
    events*: seq[(EventKind, EventHandler)]


proc render*(self: Component, bodyWrapper: VNode): VNode =
  result = newVNode(self.vNodeKind)

  let
    defaultStyle = style()
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(customStyle)

  result.style = style

  for node in bodyWrapper:
    result.add node

  for event in self.events:
    result.events.add (event[0], event[1], nil)

