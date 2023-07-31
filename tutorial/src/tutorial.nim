import karax/karax

import kraut

import tutorial/routes
import tutorial/pages/notfound


let renderer = routeRenderer(routes.routes, defaultRenderer = notfound.render)

setRenderer(renderer)

