import karax/[karax, karaxdsl, kbase, kdom, vdom]
import kraut/context

import ../[pages, state, layout]
import ../components/notification


proc render*(context: Context): VNode =
  currentPage = Page.about
  document.title = "about"

  layout.render buildHtml(tdiv) do:
    h1: text "about"

    button:
      text kstring"Press me"
      proc onClick =
        var
          n = new Notification

        n.kind = NotificationKind.success
        n.title = "About page opened"
        n.contentwrapper = buildhtml(tdiv):
          p:
            text kstring"this is something "
            bold:
              text kstring"bold"
            text kstring"."
          p:
            text kstring"this is a "
            a(href = kstring"https://ya.ru", `target` = kstring"_blank"):
              text "link"
            text kstring"."

        state.notifications.push(n)

    for _ in 1..5:
      p:
        text kstring"lorem ipsum dolor sit amet, consectetur adipiscing elit. Quid est igitur, cur ita semper deum appellet Epicurus beatum et aeternum? Quaesita enim virtus est, non quae relinqueret naturam, sed quae tueretur. Duo Reges: constructio interrete. Illa argumenta propria videamus, cur omnia sint paria peccata. Qui est in parvis malis. Qui ita affectus, beatum esse numquam probabis; Dicimus aliquem hilare vivere; Illis videtur, qui illud non dubitant bonum dicere -;"
      p:
        text kstring"Prodest, inquit, mihi eo esse animo. Nam his libris eum malo quam reliquo ornatu villae delectari. Sed tamen enitar et, si minus multa mihi occurrent, non fugiam ista popularia. Cur iustitia laudatur? Quid de Pythagora? Levatio igitur vitiorum magna fit in iis, qui habent ad virtutem progressionis aliquantum. Et hercule-fatendum est enim, quod sentio -mirabilis est apud illos contextus rerum. Recte, inquit, intellegis. Primum in nostrane potestate est, quid meminerimus?"
      p:
        text kstring"Ergo opifex plus sibi proponet ad formarum quam civis excellens ad factorum pulchritudinem? Ita multo sanguine profuso in laetitia et in victoria est mortuus. Quo studio Aristophanem putamus aetatem in litteris duxisse? Nec mihi illud dixeris: Haec enim ipsa mihi sunt voluptati, et erant illa Torquatis. Reguli reiciendam; Itaque hic ipse iam pridem est reiectus;"

