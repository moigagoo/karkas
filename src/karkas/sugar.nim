import karax/[kbase, vstyles]

when defined(js):
  import karax/jdict


func k*(x: string): kstring =
  ## Convert string to kstring.

  kstring x


func `<-`*(a, b: VStyle): VStyle =
  ## Merge style a with style b.

  a.merge(b)


func `<-`*(a: VStyle, b: varargs[(StyleAttr, kstring)]): VStyle =
  ## Merge style a with style b where b is constructed on the fly from key-value pairs.

  a.merge(style b)

