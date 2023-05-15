import karax/karax

import kraut

import karkas/routes
import karkas/pages/notfound


let renderer = routeRenderer(routes.routes, defaultRenderer = notfound.render)

setRenderer(renderer)

