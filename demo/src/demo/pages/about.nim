import karax/[karaxdsl, kdom, vdom]
import kraut/context

import ../[pages, state, layout]


proc render*(context: Context): VNode =
  currentPage = Page.about
  document.title = "about"

  layout.render buildHtml(tdiv) do:
    h1: text "about"

