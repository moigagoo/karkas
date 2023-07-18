import std/strutils

import karax/[karax, kbase, karaxdsl, kdom, vdom, vstyles]
import kraut/context
import karkas
import karkas/sugar

import ../pages, ../state


proc render*(context: Context): VNode =
  currentPage = Page.index
  document.title = "index"

  buildHtml:
    tdiv:
      tdiv(style = hbox() <- topPanel() <- sticky()):
        tdiv(style = box()):
          p:
            text k"Item 1"
        tdiv(style = box()):
          p:
            text k"Item 2"

      tdiv(style = floatingBox(top, center) <- {width: k"20%", border: k"solid red"}):
        tdiv(style = vBox()):
          for i in 1..5:
            tdiv(style = box() <- {border: k"dotted blue"}):
              p:
                text "This is text"

      h1:
        text "Index"

      tdiv(style = hbox()):
        tdiv(style = box(1) <- {border: k"solid"})
        tdiv(style = box(1) <- hbox() <- {border: k"dotted"}):
          tdiv(style = box(1)):
            h2:
              text "Header"
            p:
              text "Paragraph"

          tdiv(style = box(2)):
            h2:
              text "Second header"
            p:
              text "Paragraph"

          tdiv(style = box(1)): 
            h2:
              text "Pure div"
            p:
              text "Paragraph"

