import karax/[vdom, vstyles]


type
  Component*[K: static VNodeKind = VNodeKind.tdiv] = object of RootObj
    style*: VStyle
    events*: seq[(EventKind, EventHandler)]


proc render*[K: static VNodeKind](self: Component[K], bodyWrapper: VNode): VNode =
  result = newVNode(K)

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

