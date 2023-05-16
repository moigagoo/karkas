import karax/[karaxdsl, kdom, vdom]
import kraut/context

import ../pages
import ../state


proc render*(context: Context): VNode =
  currentPage = Page.notfound
  document.title = "notfound"

  buildHtml(tdiv):
    h1: text "notfound"

