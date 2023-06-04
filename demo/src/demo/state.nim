import karax/[karax, kdom, vdom]

import pages
import components/notification


var
  currentPage*: Page
  notifications*: seq[ref Notification]

func push*(notifications: var seq[ref Notification], notification: ref Notification) =
  notification.events = @{
    onclick: proc(event: Event, target: VNode) {.closure.} =
      notification.visible = false
      redraw()
      discard setTimeout(
        proc =
          let i = notifications.find(notification)
          state.notifications.delete(i)
          redraw(),
        500
      )
  }

  notifications.add(notification)

