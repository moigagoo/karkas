import karax/[karaxdsl, kdom, vdom]
import kraut/context

import ../pages
import ../state
import ../layouts/base


proc render*(context: Context): VNode =
  currentPage = Page.index
  document.title = "index"

  base.render buildHtml(tdiv) do:
    h1: text "index"

    for i in 1..100:
      p: text "Lorem ipsum dolor sit amet"

