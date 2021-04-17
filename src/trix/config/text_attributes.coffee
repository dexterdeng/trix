Trix.config.textAttributes =
  bold:
    tagName: "strong"
    inheritable: true
    parser: (element) ->
      style = window.getComputedStyle(element)
      style["fontWeight"] is "bold" or style["fontWeight"] >= 600
  italic:
    tagName: "em"
    inheritable: true
    parser: (element) ->
      style = window.getComputedStyle(element)
      style["fontStyle"] is "italic"
  href:
    groupTagName: "a"
    parser: (element) ->
      {attachmentSelector} = Trix.AttachmentView
      matchingSelector = "a:not(#{attachmentSelector})"
      if link = Trix.findClosestElementFromNode(element, {matchingSelector})
        link.getAttribute("href")
  strike:
    tagName: "del"
    inheritable: true

  frozen:
    style: { "backgroundColor": "highlight" }

  foregroundColor:
    inheritable:!0
    styleProperty:"color"
    parser: (element) ->
      colors ="#887626 #B95E06 #CF0000 #D81CAA #9013FE #0562B9 #118A0F #945216 #666666".split(" ")
      color = null
      while element && element.tagName != 'TRIX-EDITOR'
        color = element.style['foregroundColor']
        if color && colors.indexOf(color) >= 0
          return color

        element = element.parentElement

  backgroundColor:
    inheritable:!0
    styleProperty:"backgroundColor"
    parser: (element) ->
      colors = "#FAF785 #FFF0DB #FFE5E5 #FFE4F7 #F2EDFF #E1EFFC #E4F8E2 #EEE2D7 #F2F2F2".split(" ")

      color = null
      while element && element.tagName != 'TRIX-EDITOR'
        color = element.style['backgroundColor']
        if color && colors.indexOf(color) >= 0
          return color

        element = element.parentElement

