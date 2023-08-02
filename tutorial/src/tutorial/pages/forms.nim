import karax/[karaxdsl, kdom, vdom]
import kraut/context
import karkas

import ../pages
import ../state
import ../layout


proc render*(context: Context): VNode =
  currentPage = Page.forms
  document.title = "forms"

  layout.render buildHtml(tdiv) do:
    h1: text "forms"

    tdiv(style = {width: "500px"}):
      tdiv(style = vStack()):
        tdiv(style = hStack(direction = rightToLeft) <- {margin: "10px"}):
          tdiv(style = box(2)):
            input(name = k"first_name", style = {width: k"100%"})
          tdiv(style = box(1)):
            label(`for` = k"first_name"):
              text k"First name:"
        tdiv(style = hStack(direction = rightToLeft) <- {margin: "10px"}):
          tdiv(style = box(2)):
            input(name = k"last_name", style = {width: k"100%"})
          tdiv(style = box(1)):
            label(`for` = k"last_name"):
              text k"Last name:"
        tdiv(style = hStack(direction = rightToLeft) <- {margin: "10px"}):
          tdiv(style = box(2)):
            textarea(name = k"about_me", style = {width: k"100%"})
          tdiv(style = box(1)):
            label(`for` = k"about_me"):
              text k"About me:"
        tdiv(style = hStack() <- {margin: "10px"}):
          tdiv(style = box(1)):
            input(`type` = k"radio", id = k"white", name = k"color", checked = true)
            label(`for` = k"white"):
              text k"White"
          tdiv(style = box(1)):
            input(`type` = k"radio", id = k"blue", name = k"color")
            label(`for` = k"blue"):
              text k"Blue"
          tdiv(style = box(1)):
            input(`type` = k"radio", id = k"red", name = k"color")
            label(`for` = k"red"):
              text k"Red"

