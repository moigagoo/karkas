import karax/vstyles
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
  ## Basic rectangular element that can be put inside stacks. 
  
  style {StyleAttr.flex: k $size}


func hStack*(direction = HDirection.leftToRight): VStyle =
  ## Horizontal stack. Boxes inside it are stacked horizontally according to ``direction``.

  let 
    defaultStyle = style {StyleAttr.display: k"flex"}
    directionStyle = case direction
      of HDirection.leftToRight:
        style {StyleAttr.flexDirection: k"row"}
      of HDirection.rightToLeft:
        style {StyleAttr.flexDirection: k"row-reverse"}

  defaultStyle <- directionStyle


func vStack*(direction = VDirection.topToBottom): VStyle =
  ## Vertical stack. Boxes inside it are stacked vertically according to ``direction``.

  let
    defaultStyle = style {StyleAttr.display: k"flex"}
    directionStyle = case direction
      of VDirection.topToBottom:
        style {StyleAttr.flexDirection: k"column"}
      of VDirection.bottomToTop:
        style {StyleAttr.flexDirection: k"column-reverse"}

  defaultStyle <- directionStyle


func topPanel*: VStyle =
  ## Full-width horizontal panel attached to the top of the page.

  style {StyleAttr.top: k"0", StyleAttr.width: k"100%"}


func bottomPanel*: VStyle =
  ## Full-width horizontal panel attached to the bottom of the page.

  style {StyleAttr.bottom: k"0", StyleAttr.width: k"100%"}


func sticky*: VStyle =
  ## Make a top or a bottom panel (or any other element) sticky, i.e. always visible regardless of page scroll.

  style {StyleAttr.position: k"sticky"}


func vBar*: VStyle =
  ## Vertical bar that occupies the entire page height. Useful for sidebars.

  style {StyleAttr.height: k"100vh"}


func fBox*(vPosition = VPosition.top, hPosition = HPosition.right): VStyle =
  ##[ Floating box. A container that can be positioned over other page elements in nine anchor points based on ``vPosition`` and ``hPosition``.

  Useful for notification stacks.
  ]##

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

