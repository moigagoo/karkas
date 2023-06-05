import karax/[karaxdsl, kbase, vdom, vstyles]

import karkas/[box, vbox]


type
  NotificationKind* = enum
    info, success, warning, error
  Notification* = object of Box
    kind* = NotificationKind.info
    title*: string
    contentWrapper*: VNode
    visible* = true


proc render*(self: Notification): VNode =
  let
    defaultStyle = style {
      border: kstring"1px solid",
      width: kstring"100%",
      height: kstring"80px",
      transition: kstring"all .2s",
      transform: 
        if self.visible:
          kstring"translateX(0) scaleY(100%)"
        else:
          kstring"translateX(100%) scaleY(0)",
    }
    kindStyle = case self.kind
      of info:
        style {background: kstring"lightyellow"}
      of success:
        style {background: kstring"lightgreen"}
      of warning:
        style {background: kstring"orange"}
      of error:
        style {background: kstring"red"}
    customStyle =
      if not self.style.isNil:
        self.style
      else:
        style()
    style = defaultStyle.merge(kindStyle).merge(customStyle)
    bodyWrapper = buildHtml(tdiv):
      let container = VBox()
      container.render buildHtml(tdiv) do:
        tdiv(style = {fontWeight: kstring"bold"}): 
          text kstring self.title
        tdiv:
          for node in self.contentWrapper:
            node

  var
    super = Box(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

