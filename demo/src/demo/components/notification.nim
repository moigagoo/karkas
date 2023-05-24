import karax/[karaxdsl, kbase, vdom, vstyles]

import karkas/[box, vbox]


type
  NotificationKind* = enum
    info, success, warning, error
  Notification* = object of Box
    nkind* = NotificationKind.info
    title*: string
    content*: VNode


proc render*(self: Notification): VNode =
  let
    defaultStyle = style {border: kstring"1px solid", width: kstring"100%", height: kstring"80px"}
    kindStyle = case self.nkind
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
          for node in self.content:
            node

  var
    super = Box(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

