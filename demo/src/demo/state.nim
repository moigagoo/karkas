import karax/vdom

import pages


var
  currentPage*: Page
  notifications*: seq[VNode]
  notificationCounter* = 0

