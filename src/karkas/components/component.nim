import karax/[karaxdsl, vdom, vstyles]


type
  Component* = object of RootObj
    id*: int = 0
    style*: VStyle
    events*: seq[(EventKind, EventHandler)]

proc render*(self: Component, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style()
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(customStyle)

  result = buildHtml:
    tdiv(style = style):
      for node in bodyWrapper:
        node

  for event in self.events:
    result.events.add (event[0], event[1], nil)

