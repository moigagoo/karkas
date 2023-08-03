import nimib, nimibook


nbInit(theme = useNimibook)

nbText: """
# Basics

## Boxes

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

3. You should see this in your browser at [http://localhost:1337/app.html#/](http://localhost:1337/app.html#/):
"""

nbKaraxCode:
  import karkas/styles

  karaxHtml:
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

   Rebuild the app with `sauer make` and refresh the browser page:
"""

nbKaraxCode:
  import karkas/styles

  karaxHtml:
    tdiv(style = box().merge(style {border: kstring"solid"})):
      p: text "Box one" 
    tdiv(style = box().merge(style {border: kstring"solid"})):
      p: text "Box two" 

nbText: """
## Stacks

**Stack** is a rectangular container for boxes. There are two kinds of stacks: vertical and horizontal.

Let's put our boxes into a stack and play with the way they fit inside it.

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

   Rebuild the app with `sauer make` and refresh the browser page:
"""

nbKaraxCode:
  import karkas/styles

  karaxHtml:
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

   Rebuild the app with `sauer make` and refresh the browser page:
"""

nbKaraxCode:
  import karkas/styles

  karaxHtml:
    tdiv(style = hStack()):
      tdiv(style = box(size = 1).merge(style {border: kstring"solid"})):
        p: text "Box one" 
      tdiv(style = box(size = 2).merge(style {border: kstring"solid"})):
        p: text "Box two" 

nbText: """
By setting `size` values for the boxes inside a stack, you control the proportions of space distribution between the boxes. In the example above, we set the second box to be twice larger than the first one.


## Sugar

Let's now use `karkas/sugar` to make our code less noisy and more pleasant to work with.

We'll use `<-` func to merge styles. It has several useful properties compared to its built-in `merge` counterpart:

1. It automatically converts `string` to `kstring`.
2. It automatically applies `style` to the passed `(StyleAttr, kstring)` array.


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


   Rebuild the app with `sauer make` and refresh the browser page.

   The result is the same but the code is now more approachable:
"""

nbKaraxCode:
  import karkas

  karaxHtml:
    tdiv(style = hStack()):
      tdiv(style = box(size = 1) <- {border: "solid"}):
        p: text "Box one" 
      tdiv(style = box(size = 2) <- {border: "solid"}):
        p: text "Box two" 

nbSave

