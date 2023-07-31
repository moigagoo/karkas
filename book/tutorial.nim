import nimib, nimibook


nbInit(theme = useNimibook)

nbText: """
# Tutorial

In this tutorial, we'll learn procs and syntax sugar provided by Karkas and build a layout with them. We'll start with basic rectangles, then play around with vertical and horizontal stacks, and build a form by composing those stacks. Finally, we'll create a layout that can show different content while preserving the basic page structure.


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

nbImage(url="img/tutorial_1.png")

nbText: """
4. Let's make the boxes visible bye adding borders around them by mixing in custom styles:

    ```nim
    import karax/[karaxdsl, kdom, vdom, kbase, vstyles]
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

nbImage(url="img/tutorial_2.png")

nbText: """
# Stacks

**Stack** is a rectangular container for boxes. There are two kinds of stacks: vertical and horizontal.

Let's put our boxes into a stacks and play with the way they fit inside them.

1. Add a new `tdiv` with style `hStack`:

    ```nim
    import karax/[karaxdsl, kdom, vdom, kbase, vstyles]
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

nbImage(url="img/tutorial_3.png")

nbText: """
2. By default, a box takes as little space inside the stack as possible. To control how much space a box “wants” to have, set its `size` param:

    ```nim
    import karax/[karaxdsl, kdom, vdom, kbase, vstyles]
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

nbImage(url="img/tutorial_4.png")

nbText: """
# Sugar

Let's now use `karkas/sugar` to make our code less noisy.

To merge styles, we'll use `<-` func. It has several useful properties compared to its built-in `merge` counterpart:

1. it automatically converts `string` to `kstring`
2. it automatically applies `style` to the passed `(StyleAttr, kstring)` array

Also, you don't hae to import `karax/vstyles` or `karax/kbase` if you import `karkas/sugar`.

As a result, the code becomes more readable:

```nim
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
```
"""

nbSave

