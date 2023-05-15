import karax/[karaxdsl, kdom, vdom]
import kraut/context

import ../pages
import ../state
import ../layouts/base


proc render*(context: Context): VNode =
  currentPage = Page.about
  document.title = "about"

  base.render buildHtml(tdiv) do:
    h1: text "about"

    for i in 1..100:
      p: text "Foo bar boo baz"

