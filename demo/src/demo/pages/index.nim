import karax/[karax, kbase, karaxdsl, kdom, vdom]
import kraut/context

import ../[pages, state, layout]
import ../components/notification



var
  entryText = ""


proc render*(context: Context): VNode =
  currentPage = Page.index
  document.title = "index"

  layout.render buildHtml(tdiv) do:
    h1: text "index"

    textarea:
      proc onKeyUp(event: Event, target: VNode) =
        entryText = $target.value

    button:
      text "Press me"
      proc onClick(event: Event, target: VNode) =
        let
          content = buildHtml(tdiv):
            p:
              text kstring entryText
        var
          n = Notification(nkind: NotificationKind.info, title: "Click to close", content: content)

        n.events = @{
          EventKind.onclick: proc(event: Event, target: VNode) {.closure.} =
            let i = state.notifications.find(n)
            state.notifications.delete(i)
            redraw()
        }

        state.notifications.add n

