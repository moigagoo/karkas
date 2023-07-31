import karax/[karaxdsl, kdom, vdom]
import kraut/context
import karkas/[styles, sugar]

import ../pages
import ../state


proc render*(context: Context): VNode =
  currentPage = Page.index
  document.title = "index"

  buildHtml(tdiv):
    h1: text "index"
    tdiv(style = hStack()):
      tdiv(style = box(size = 1) <- {border: "solid"}):
        p: text "Box one" 
      tdiv(style = box(size = 2) <- {border: "solid"}):
        p: text "Box two" 

