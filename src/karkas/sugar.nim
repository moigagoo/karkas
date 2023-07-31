import karax/[kbase, vstyles]

when defined(js):
  import karax/jdict


export kbase, vstyles


func k*(x: string): kstring =
  ## Convert string to kstring.

  kstring x


func `<-`*(a, b: VStyle): VStyle =
  ## Merge style a with style b.

  a.merge(b)


func `<-`*(a: VStyle, b: varargs[(StyleAttr, kstring)]): VStyle =
  ## Merge style a with style b where b is constructed on the fly from key-value pairs.

  a.merge(style b)


func `<-`*(a: VStyle, b: varargs[(StyleAttr, string)]): VStyle =
  ## Merge style a with style b where b is constructed on the fly from key-value pairs and values are of type string.

  var kb: seq[(StyleAttr, kstring)]

  for (key, val) in b:
    kb.add (key, k(val))

  a <- kb

