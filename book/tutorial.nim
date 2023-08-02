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

3. Build the app:

    ```shell
    $ sauer make
    ```

4. Run a local web server and open the app in your browser:

    ```shell
    $ sauer serve --browse
    ```
"""

nbSave

