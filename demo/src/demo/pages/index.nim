import karax/[karax, kbase, karaxdsl, kdom, vdom, vstyles]
import kraut/context
import karkas/[styles, sugar]

import ../pages, ../state


proc render*(context: Context): VNode =
  currentPage = Page.index
  document.title = "index"

  buildHtml:
    tdiv:
      tdiv(style = hbox() <- topPanel() <- sticky() <- {background: "white", boxShadow: "10px 0px 10px"}):
        tdiv(style = box() <- {margin: "10px"}):
          a(href = "#/"):
            text k"Item 1"
        tdiv(style = box() <- {margin: "10px"}):
          a(href = "#/"):
            text k"Item 2"

      tdiv(style = fBox(top, right) <- {width: "20%", border: "solid red", background: "white"}):
        tdiv(style = vBox()):
          for notification in state.notifications:
            notification

      tdiv(style = hbox()):
        tdiv(style = box(1) <- vBar()):
          h2:
            text k"Sidebar"

        tdiv(style = box(4) <- hbox()):
          tdiv(style = box(1) <- {border: "solid"}):
            textarea(style = {width: "100%", height: "100%"}):
              proc onkeyupenter(e: Event, n: VNode) =
                let notification = buildHtml:
                  tdiv(style = box() <- {border: "dotted blue"}, id = k $state.notificationCounter):
                    p:
                      text n.value
                    proc onclick(e: Event, n: VNode) =
                      let i = state.notifications.find(n)
                      state.notifications.delete(i)

                state.notifications.add(notification)
                inc state.notificationCounter

                discard setTimeout(
                  proc =
                    let i = state.notifications.find(notification)
                    state.notifications.delete(i) 
                    redraw(),
                  2000
                )

                n.value = k""

          tdiv(style = box(1) <- hbox() <- {border: "dotted"}):
            tdiv(style = box(1)):
              h2:
                text "Header"
              p:
                text "Paragraph"

            tdiv(style = box(2)):
              h2:
                text "Second header"
              p:
                text "Paragraph"

            tdiv(style = box(1)): 
              h2:
                text "Pure div"
              p:
                text "Paragraph"

        tdiv(style = box(1) <- vBar()):
          h2:
            text k"Sidebar"


