import karax/karax

import kraut

import demo/routes
import demo/pages/notfound


let renderer = routeRenderer(routes.routes, defaultRenderer = notfound.render)

setRenderer(renderer)

