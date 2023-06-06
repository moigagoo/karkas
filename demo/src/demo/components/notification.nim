import karax/[karaxdsl, kbase, vdom, vstyles]

import karkas/[box, vbox, hbox]


type
  NotificationKind* = enum
    info, success, warning, error
  Notification* = object of Box
    kind* = NotificationKind.info
    title*: string
    contentWrapper*: VNode
    visible* = true
    closeButton*: Box


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
      let
        container = VBox()
        header = HBox()
        body = Box()
        titleBox = HBox(flex: "9", style: style {fontWeight: kstring"bold"})
        closeBox = HBox(flex: "1", direction: HDirection.rightToLeft)
      container.render buildHtml(tdiv) do:
        header.render buildHtml(tdiv) do:
          titleBox.render buildHtml(tdiv) do:
            text kstring self.title
          closeBox.render buildHtml(tdiv) do:
            self.closeButton.render buildHtml(tdiv) do:
              button:
                text kstring"❌"
        tdiv:
          for node in self.contentWrapper:
            node

  var
    super = Box(self)

  super.style = style
  super.events = self.events

  super.render(bodyWrapper)

