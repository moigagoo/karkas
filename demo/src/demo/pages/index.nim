import karax/[karaxdsl, kdom, vdom]
import kraut/context

import ../[pages, state, layout]


proc render*(context: Context): VNode =
  currentPage = Page.index
  document.title = "index"

  layout.render buildHtml(tdiv) do:
    h1: text "index"

