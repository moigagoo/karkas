import karax/[karaxdsl, kdom, vdom]
import kraut/context
import karkas

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

    tdiv(style = hStack() <- {width: "300px", padding: "10px"}):

      # The entire form is a vertical stack.
      tdiv(style = vStack() <- box(1)):

        # Each form field is a row in the stack.
        # It is itself a horizontal stack that holds the input field and its label.
        # For our convenience, so that we first type the field and then its label, set the stacking direction to `rightToLeft`.
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
            input(`type` = k"radio", id = k"white", name = k"color")
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

