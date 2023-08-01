# Karkas

**Karkas** is a library for [Karax](https://github.com/karaxnim/karax/) frontend framework that makes it a bit easier to build layouts and work with styles.

Karkas is split into two modules: `karkas/styles` and `karkas/sugar`. 

`karkas/styles` contains ready to use styles to turn HTML elements into boxes and containers.

`karkas/sugar` contains `<-` func that merges two styles and `k` func that turns a `string` into a `kstring`. Those can be used entirely on their own as syntactic sugar to Karax regardless of Karkas's styles.

- [Homepage](https://karkas.nim.town)
- [Tutorial](/tutorial.html)
- [API Docs](/apidocs/theindex.html)
- [Repo](https://github.com/moigagoo/karkas)


# Installation

Add Karkas to your  .nimble file:

```nim
requires karkas
```

