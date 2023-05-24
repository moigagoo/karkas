import pages
import components/notification


const
  maxNotificationCount = 100


var
  currentPage*: Page
  notifications*: seq[Notification]


proc push*(queue: var seq[Notification], n: Notification) =
  queue.add n

  if len(queue) > maxNotificationCount:
    queue.delete(0)

