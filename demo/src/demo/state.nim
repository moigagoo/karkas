import karax/[karax, kdom, vdom]

import pages
import components/notification


var
  currentPage*: Page
  notifications*: seq[ref Notification]


proc removeNotification*(notification: ref Notification) =
  notification.visible = false

  clearInterval notification.ttlClock
  clearTimeout notification.ttlTimer

  redraw()

  discard setTimeout(
    proc =
      let i = notifications.find(notification)
      state.notifications.delete(i)
      redraw(),
    500
  )

func push*(notifications: var seq[ref Notification], notification: ref Notification) =
  notification.closeButton.events = @{
    onclick: proc (event: Event, target: VNode) {.closure.} = removeNotification(notification)
  }

  notifications.add(notification)

  notification.ttlClock = setInterval(
    proc =
      dec notification.ttl
      redraw(),
    1000
  )

  notification.ttlTimer = setTimeout(
    proc = removeNotification(notification),
    notification.ttl * 1000
  )

