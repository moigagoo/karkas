import nimib, nimibook


nbInit(theme = useNimibook)

nbText: """
# Layouts

In the closing part of the tutorial, we'll create a layout to be used on all pages of the tutorial app. We'll build it as a separate module that is imported by individual pages.

The layout will consist of a top navigation panel and the content block underneath it. The navigation panel will have basic logic preventing the user from going to the page they're already on.

1. In the tutorial app folder, in `src/tutorial`, create a file called `layout.nim` with the following content:

    ```nim
    import karax/[karaxdsl, kdom, vdom]
    import karkas

    import pages
    import state


    proc render*(body: VNode): VNode =
      buildHtml:
        tdiv:
          for node in body:
            node
    ```

2. Now, do two things in `src/tutorial/pages/index.nim`, `src/tutorial/pages/forms.nim`, and `src/tutorial/pages/notfound.nim`:

   - Add `import ../layout` under `import ../state`.
   - Replace `buildHtml(tdiv)` with `layout.render buildHtml(tdiv) do`.

   For example, `src/tutorial/pages/index.nim` should look like this:

   ```nim
    import karax/[karaxdsl, kdom, vdom]
    import kraut/context
    import karkas

    import ../pages
    import ../state
    import ../layout


    proc render*(context: Context): VNode =
      currentPage = Page.index
      document.title = "index"

      layout.render buildHtml(tdiv) do:
        h1: text "index"
        tdiv(style = hStack()):
          tdiv(style = box(size = 1) <- {border: "solid"}):
            p: text "Box one" 
          tdiv(style = box(size = 2) <- {border: "solid"}):
            p: text "Box two" 
   ```

3. Rebuild the app with `sauer make`, open it in your browser, and make sure that nothing changed. Except that now, we have factored out common logic to a shared module, which we can now edit and thus affect all pages at once.

4. Open `src/tutorial/layout.nim` in your favorite editor and update the code:

    ```nim
    import karax/[karaxdsl, kdom, vdom]
    import karkas

    import pages
    import state


    proc render*(body: VNode): VNode =
      buildHtml:
        tdiv(style = vStack()):
          tdiv(style = topPanel() <- hStack() <- {padding: "10px", boxShadow: "0 0 10px"})
          tdiv:
            for node in body:
              node
    ```

   We've set up basic structure for our layout: a vertical stack with a panel at the top and a content block at the bottom.

   Note how we describe the top panel. By composing `topPanel()` with `hStack()` and custom styles, we define a full-width horizontal stack container with padding and shadow.

   Rebuild the app with `sauer make` and check the new (now empty) panel:
"""

nbKaraxCode:
  import karkas

  proc layout*(body: VNode): VNode =
    buildHtml:
      tdiv(style = vStack()):
        tdiv(style = topPanel() <- hStack() <- {padding: "10px", boxShadow: "0 0 10px"})
        tdiv:
          for node in body:
            node

  karaxHtml:
    layout buildHtml(tdiv) do:
      h1: text "index"
      tdiv(style = hStack()):
        tdiv(style = box(size = 1) <- {border: "solid"}):
          p: text "Box one" 
        tdiv(style = box(size = 2) <- {border: "solid"}):
          p: text "Box two" 

nbText: """
5. Now let's define a proc that generates a navigation entry and invoke it in the top panel. Based on the current page, it shows either a link to a page or just its name:

    ```nim
    import karax/[karaxdsl, kdom, vdom]
    import karkas

    import pages
    import state


    proc navEntry(page: Page, url, caption: string): VNode =
      buildHtml:
        tdiv(style = box() <- {minWidth: "50px"}):
          if state.currentPage != page:
            a(href = k url):
              text k caption
          else:
            text k caption

    proc render*(body: VNode): VNode =
      buildHtml:
        tdiv(style = vStack()):
          tdiv(style = topPanel() <- hStack() <- {padding: "10px", boxShadow: "0 0 10px"}):
            navEntry(index, "#/", "Index")
            navEntry(forms, "#/forms", "Forms")
          tdiv:
            for node in body:
              node
    ```

Rebuild the app with `sauer make` and see the complete app with navigation:
"""

nbKaraxCode:
  import karkas

  type Page = enum
    index
    forms
    notfound

  type State = object
    currentPage: Page

  var state: State


  proc navEntry(page: Page, url, caption: string): VNode =
    buildHtml:
      tdiv(style = box() <- {minWidth: "50px"}):
        if state.currentPage != page:
          a(href = k url):
            text k caption
            proc onclick = state.currentPage = page
        else:
          text k caption

  proc layout*(body: VNode): VNode =
    buildHtml:
      tdiv(style = vStack()):
        tdiv(style = topPanel() <- hStack() <- {padding: "10px", boxShadow: "0 0 10px"}):
          navEntry(index, "#/", "Index")
          navEntry(forms, "#/forms", "Forms")
        tdiv:
          for node in body:
            node

  karaxHtml:
    case state.currentPage
    of index:
      layout buildHtml(tdiv) do:
        h1: text "index"
        tdiv(style = hStack()):
          tdiv(style = box(size = 1) <- {border: "solid"}):
            p: text "Box one" 
          tdiv(style = box(size = 2) <- {border: "solid"}):
            p: text "Box two" 
    of forms:
      layout buildHtml(tdiv) do:
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
    else:
      discard

nbSave

