import std/strutils

import karax/[karax, kbase, karaxdsl, kdom, vdom]
import kraut/context
import karkas/[vbox, hbox, box]

import ../[pages, state, layout]
import ../components/notification


var
  entryText = ""
  nkind = NotificationKind.info


proc render*(context: Context): VNode =
  currentPage = Page.index
  document.title = "index"

  layout.render buildHtml(tdiv) do:
    h1: text "index"

    let
      form = HBox()
      leftSide = VBox()
      rightSide = VBox()
      textareaBox = Box()
      buttonBox = Box()

    form.render buildHtml(tdiv) do:
      leftSide.render buildHtml(tdiv) do:
        textareaBox.render buildHtml(tdiv) do:
          textarea(autofocus = "1"):
            proc onKeyUp(event: Event, target: VNode) =
              entryText = $target.value
        buttonBox.render buildHtml(tdiv) do:
          button:
            text "Press me"
            proc onClick(event: Event, target: VNode) =
              let
                contentWrapper = buildHtml(tdiv):
                  p:
                    text kstring entryText
              var
                n = Notification(nkind: nkind, title: "Click to close", contentWrapper: contentWrapper)

              n.events = @{
                onclick: proc(event: Event, target: VNode) {.closure.} =
                  let i = state.notifications.find(n)
                  state.notifications[i].visible = false
                  redraw()
              }

              state.notifications.push n

      rightSide.render buildHtml(tdiv) do:
        for k in NotificationKind:
          let hb = HBox()
          hb.render buildHtml(tdiv) do:
            input(name = kstring"nkind", value = kstring $k, `type` = kstring"radio", id = kstring $k, checked = (k == nkind).toChecked):
              proc onChange(event: Event, target: VNode) =
                nkind = parseEnum[NotificationKind]($target.value)
            label(`for` = kstring $k):
              text kstring $k

