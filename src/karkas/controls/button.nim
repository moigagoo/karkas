import karax/[kbase, vdom, vstyles]

import ../component


type
  Super = Component[VNodeKind.button]
  Button* = object of Super


proc render*(self: Button, bodyWrapper: VNode): VNode =
  let
    defaultStyle = style()
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(customStyle)

  var
    super = Super(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

