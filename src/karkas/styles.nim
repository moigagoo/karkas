import karax/[kbase, vstyles]
import sugar


type
  HDirection* = enum
    leftToRight, rightToLeft
  VDirection* = enum
    topToBottom, bottomToTop
  VPosition* = enum
    top, center, bottom
  HPosition* = enum
    left, center, right
 

func box*(size = 0): VStyle =
 style {StyleAttr.flex: k $size}


func hBox*(direction = HDirection.leftToRight): VStyle =
  let 
    defaultStyle = style {StyleAttr.display: k"flex"}
    directionStyle = case direction
      of HDirection.leftToRight:
        style {StyleAttr.flexDirection: k"row"}
      of HDirection.rightToLeft:
        style {StyleAttr.flexDirection: k"row-reverse"}

  defaultStyle <- directionStyle


func vBox*(direction = VDirection.topToBottom): VStyle =
  let
    defaultStyle = style {StyleAttr.display: k"flex"}
    directionStyle = case direction
      of VDirection.topToBottom:
        style {StyleAttr.flexDirection: k"column"}
      of VDirection.bottomToTop:
        style {StyleAttr.flexDirection: k"column-reverse"}

  defaultStyle <- directionStyle


func topPanel*(sticky = false): VStyle =
  style {StyleAttr.top: k"0", StyleAttr.width: k"100%"}


func bottomPanel*(sticky = false): VStyle =
  style {StyleAttr.bottom: k"0", StyleAttr.width: k"100%"}


func sticky*: VStyle =
  style {StyleAttr.position: k"sticky"}


func vBar*: VStyle =
  style {StyleAttr.height: k"100vh"}


func fBox*(vPosition = VPosition.top, hPosition = HPosition.right): VStyle =
  let
    defaultStyle = style {StyleAttr.position: k"fixed"}
    vPositionStyle = case vPosition
      of VPosition.top:
        style {StyleAttr.top: k"0"}
      of VPosition.center:
        style {StyleAttr.top: k"50%", StyleAttr.transform: k"translateY(-50%)"}
      of VPosition.bottom:
        style {StyleAttr.bottom: k"0"}
    hPositionStyle = case hPosition
      of HPosition.left:
        style {StyleAttr.left: k"0"}
      of HPosition.center:
        style {StyleAttr.left: k"50%", StyleAttr.transform: k"translateX(-50%)"}
      of HPosition.right:
        style {StyleAttr.right: k"0"}
    centerStyle =
      if vPosition == VPosition.center and hPosition == HPosition.center:
        style {StyleAttr.transform: k"translateY(-50%) translateX(-50%)"}
      else:
        style()

  defaultStyle <- vPositionStyle <- hPositionStyle <- centerStyle

