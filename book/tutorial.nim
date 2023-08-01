import nimib, nimibook


nbInit(theme = useNimibook)

nbText: """
# Tutorial

In this tutorial, we'll learn procs and syntax sugar provided by Karkas and build a layout with them. We'll start with basic rectangles, then play around with vertical and horizontal stacks, and build a form by composing those stacks. Finally, we'll create a layout that can show different content while preserving the basic page structure.

See the complete code of the tutorial app in the Karkas repo: [https://github.com/moigagoo/karkas/tree/develop/tutorial](https://github.com/moigagoo/karkas/tree/develop/tutorial).


# Prerequisites

You'll need to install [Sauer](https://github.com/moigagoo/sauer) package to set up and compile the tutorial app:

```shell
$ nimble install -y sauer
```


# Setup

1. Create a new Karax project:
    
    ```shell
    $ mkdir tutorial
    $ cd tutorial
    $ nimble init # create a "binary" package
    ...
    $ sauer init
    ```

2. Open `src/tutorial/pages/index.nim` in your favorite editor. It should look like this:

    ```nim
    import karax/[karaxdsl, kdom, vdom]
    import kraut/context

    import ../pages
    import ../state


    proc render*(context: Context): VNode =
      currentPage = Page.index
      document.title = "index"

      buildHtml(tdiv):
        h1: text "index"
    ```

3. Run a local web server and open the app in your browser:

    ```shell
    $ sauer serve -b
    ```


# Boxes

**Box** is the most basic layout entity representing a rectangular block that can be put into containers.

Turning a `div` into a box describes its relationships with its parent more than with its children. In other words, `box` style tells you nothing about how the items are arranged inside it but it tells you how this element behaves relative to its neighbors in the same container.

Let's create a couple boxes to get familiar with them.

1.  Import `karkas/styles` and create two boxes inside the root div by creating two `tdiv` nodes with `style = box()`:

    ```nim
    import karax/[karaxdsl, kdom, vdom]
    import kraut/context
    import karkas/styles

    import ../pages
    import ../state


    proc render*(context: Context): VNode =
      currentPage = Page.index
      document.title = "index"

      buildHtml(tdiv):
        h1: text "index"
        tdiv(style = box()):
          p: text "Box one" 
        tdiv(style = box()):
          p: text "Box two" 
    ```

2. Build the app:

    ```shell
    $ sauer make
    ```

3. You should see this in your browser:
"""

nbKaraxCode:
  import karkas/styles

  karaxHtml:
    tdiv(style = {border: "solid gray 1px", padding: "10px"}):
      h1: text "index"
      tdiv(style = box()):
        p: text "Box one" 
      tdiv(style = box()):
        p: text "Box two" 

nbText: """
4. Let's make the boxes visible bye adding borders around them by mixing in custom styles:

    ```nim
    import karax/[karaxdsl, kdom, vdom, kbase]
    import kraut/context
    import karkas/styles

    import ../pages
    import ../state


    proc render*(context: Context): VNode =
      currentPage = Page.index
      document.title = "index"

      buildHtml(tdiv):
        h1: text "index"
        tdiv(style = box().merge(style {border: kstring"solid"})):
          p: text "Box one" 
        tdiv(style = box().merge(style {border: kstring"solid"})):
          p: text "Box two" 

    ```
"""

nbKaraxCode:
  import karkas/styles

  karaxHtml:
    tdiv(style = {border: "solid gray 1px", padding: "10px"}):
      h1: text "index"
      tdiv(style = box().merge(style {border: kstring"solid"})):
        p: text "Box one" 
      tdiv(style = box().merge(style {border: kstring"solid"})):
        p: text "Box two" 

nbText: """
# Stacks

**Stack** is a rectangular container for boxes. There are two kinds of stacks: vertical and horizontal.

Let's put our boxes into a stacks and play with the way they fit inside them.

1. Add a new `tdiv` with style `hStack`:

    ```nim
    import karax/[karaxdsl, kdom, vdom, kbase]
    import kraut/context
    import karkas/styles

    import ../pages
    import ../state


    proc render*(context: Context): VNode =
      currentPage = Page.index
      document.title = "index"

      buildHtml(tdiv):
        h1: text "index"
        tdiv(style = hStack()):
          tdiv(style = box().merge(style {border: kstring"solid"})):
            p: text "Box one" 
          tdiv(style = box().merge(style {border: kstring"solid"})):
            p: text "Box two" 
    ```
"""

nbKaraxCode:
  import karkas/styles

  karaxHtml:
    tdiv(style = {border: "solid gray 1px", padding: "10px"}):
      h1: text "index"
      tdiv(style = hStack()):
        tdiv(style = box().merge(style {border: kstring"solid"})):
          p: text "Box one" 
        tdiv(style = box().merge(style {border: kstring"solid"})):
          p: text "Box two" 

nbText: """
2. By default, a box takes as little space inside the stack as possible. To control how much space a box “wants” to have, set its `size` param:

    ```nim
    import karax/[karaxdsl, kdom, vdom, kbase]
    import kraut/context
    import karkas/styles

    import ../pages
    import ../state


    proc render*(context: Context): VNode =
      currentPage = Page.index
      document.title = "index"

      buildHtml(tdiv):
        h1: text "index"
        tdiv(style = hStack()):
          tdiv(style = box(size = 1).merge(style {border: kstring"solid"})):
            p: text "Box one" 
          tdiv(style = box(size = 2).merge(style {border: kstring"solid"})):
            p: text "Box two" 
    ```
"""

nbKaraxCode:
  import karkas/styles

  karaxHtml:
    tdiv(style = {border: "solid gray 1px", padding: "10px"}):
      h1: text "index"
      tdiv(style = hStack()):
        tdiv(style = box(size = 1).merge(style {border: kstring"solid"})):
          p: text "Box one" 
        tdiv(style = box(size = 2).merge(style {border: kstring"solid"})):
          p: text "Box two" 

nbText: """
# Sugar

Let's now use `karkas/sugar` to make our code less noisy.

To merge styles, we'll use `<-` func. It has several useful properties compared to its built-in `merge` counterpart:

1. it automatically converts `string` to `kstring`
2. it automatically applies `style` to the passed `(StyleAttr, kstring)` array

Also, you don't hae to import `karax/vstyles` or `karax/kbase` if you import `karkas/sugar`.

```nim
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
```

The result is the same but the code is now much more approachable.


# Forms

Building web forms is one of basic tasks in web development. Let's build a form with Karkas by combining stacks and putting the form elements in boxes.

1. In `index.nim`, add:

    ```nim
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
    ```
"""

nbKaraxCode:
  import karkas

  karaxHtml:
    tdiv(style = vStack() <- box(1)):

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

nbSave

