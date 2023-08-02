import karax/[karaxdsl, kdom, vdom]
import karkas

import pages
import state


proc navEntry(page: Page, url, caption: string): VNode =
  buildHtml:
    tdiv(style = box() <- {minWidth: "50px"}):
      if state.currentPage != page:
        a(href = k url):
          text k caption
      else:
        text k caption

proc render*(body: VNode): VNode =
  buildHtml:
    tdiv(style = vStack()):
      tdiv(style = topPanel() <- hStack() <- {padding: "10px", boxShadow: "0 0 10px"}):
        navEntry(index, "#/", "Index")
        navEntry(forms, "#/forms", "Forms")
      tdiv:
        for node in body:
          node

