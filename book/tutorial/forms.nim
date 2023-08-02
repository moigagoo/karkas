import nimib, nimibook


nbInit(theme = useNimibook)

nbText: """
## Forms

Building web forms is one of basic tasks in web development. Let's build a form with Karkas by combining stacks and putting the form elements in boxes.

1. Create a new page in the tutorial app by running this command inside `tutorial` folder:

    ```shell
    $ sauer pages new forms --default
    ```

2. Open `src/tutorial/pages/forms.nim` in your favorite editor and edit its content:

    ```nim
    import karax/[karaxdsl, kdom, vdom]
    import kraut/context
    import karkas

    import ../pages
    import ../state


    proc render*(context: Context): VNode =
      currentPage = Page.forms
      document.title = "forms"

      buildHtml(tdiv):
        h1: text "forms"

        tdiv(style = {width: "500px"}):
          tdiv(style = vStack())
    ``` 

   Our form is a vertical stack of fields, empty so far. This is why we're using `vStack()` style.

   **Note:** The outer fixed width `div` is there just to prevent the form from taking the entire page.

3. Now let's add a couple of inputs to the form:

    ```nim
    import karax/[karaxdsl, kdom, vdom]
    import kraut/context
    import karkas

    import ../pages
    import ../state


    proc render*(context: Context): VNode =
      currentPage = Page.forms
      document.title = "forms"

      buildHtml(tdiv):
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
    ```

   Each field is a horizontal stack of an input and its label.

   Note that we set `direction` param in `hStack` to `rightToLeft`. This makes it more natural to code our fields: instead of “label-input,” we describe a field as “input-label.”

4. Build the app with `sauer make` and open [http://localhost:1337/app.html#/forms](http://localhost:1337/app.html#/forms) in your browser. You should see something like this:
"""

nbKaraxCode:
  import karkas

  karaxHtml:
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

nbText: """
5. To complete the example, let's add another field with a textarea and three radio buttons:

    ```nim
    import karax/[karaxdsl, kdom, vdom]
    import kraut/context
    import karkas

    import ../pages
    import ../state


    proc render*(context: Context): VNode =
      currentPage = Page.forms
      document.title = "forms"

      buildHtml(tdiv):
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
    ```
   
   Rebuild the app with `sauer make` and refresh the browser page:
"""

nbKaraxCode:
  import karkas

  karaxHtml:
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

nbSave

