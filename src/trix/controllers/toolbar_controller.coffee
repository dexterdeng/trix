{handleEvent, triggerEvent, findClosestElementFromNode} = Trix

class Trix.ToolbarController extends Trix.BasicObject
  attributeButtonSelector = "[data-trix-attribute]"
  actionButtonSelector = "[data-trix-action]"
  toolbarButtonSelector = "#{attributeButtonSelector}, #{actionButtonSelector}"

  dialogSelector = "[data-trix-dialog]"
  activeDialogSelector = "#{dialogSelector}[data-trix-active]"
  dialogButtonSelector = "#{dialogSelector} [data-trix-method]"
  dialogInputSelector = "#{dialogSelector} [data-trix-input]"
  dialogColorPickerSelector = "#{dialogSelector} input.color-picker__input"
  dialogClearColorSelector = "#{dialogSelector} .remove_coloring"

  constructor: (@element) ->
    @attributes = {}
    @actions = {}
    @resetDialogInputs()

    handleEvent "mousedown", onElement: @element, matchingSelector: actionButtonSelector, withCallback: @didClickActionButton
    handleEvent "mousedown", onElement: @element, matchingSelector: attributeButtonSelector, withCallback: @didClickAttributeButton
    handleEvent "click", onElement: @element, matchingSelector: toolbarButtonSelector, preventDefault: true
    handleEvent "click", onElement: @element, matchingSelector: dialogButtonSelector, withCallback: @didClickDialogButton
    handleEvent "click", onElement: @element, matchingSelector: dialogColorPickerSelector, withCallback: @didClickDialogColorPickerButton
    handleEvent "click", onElement: @element, matchingSelector: dialogClearColorSelector, withCallback: @didClickDialogClearColorPickerButton
    handleEvent "keydown", onElement: @element, matchingSelector: dialogInputSelector, withCallback: @didKeyDownDialogInput

  # Event handlers

  didClickActionButton: (event, element) =>
    @delegate?.toolbarDidClickButton()
    event.preventDefault()
    actionName = getActionName(element)

    if @getDialog(actionName)
      @toggleDialog(actionName)
    else
      @delegate?.toolbarDidInvokeAction(actionName)

  didClickAttributeButton: (event, element) =>
    @delegate?.toolbarDidClickButton()
    event.preventDefault()
    attributeName = getAttributeName(element)

    if @getDialog(attributeName)
      @toggleDialog(attributeName)
    else
      @delegate?.toolbarDidToggleAttribute(attributeName)

    @refreshAttributeButtons()

  didClickDialogColorPickerButton: (event, element) =>
    dialogElement = findClosestElementFromNode(element, matchingSelector: dialogSelector)
    method = element.getAttribute("name")
    color = element.value
    checked =    element.checked

    if @delegate?.currentAttributes[method] == color
      checked = false
      color = null

    @[method].call(this, checked, color, dialogElement)

  didClickDialogClearColorPickerButton: (event, element) =>
    @delegate?.toolbarDidUpdateAttribute('foregroundColor', null)
    @delegate?.toolbarDidUpdateAttribute('backgroundColor', null)
    @hideDialog()

  didClickDialogButton: (event, element) =>
    dialogElement = findClosestElementFromNode(element, matchingSelector: dialogSelector)
    method = element.getAttribute("data-trix-method")
    @[method].call(this, dialogElement)

  didKeyDownDialogInput: (event, element) =>
    if event.keyCode is 13 # Enter key
      event.preventDefault()
      attribute = element.getAttribute("name")
      dialog = @getDialog(attribute)
      @setAttribute(dialog)
    if event.keyCode is 27 # Escape key
      event.preventDefault()
      @hideDialog()

  # Action buttons

  updateActions: (@actions) ->
    @refreshActionButtons()

  refreshActionButtons: ->
    @eachActionButton (element, actionName) =>
      element.disabled = @actions[actionName] is false

  eachActionButton: (callback) ->
    for element in @element.querySelectorAll(actionButtonSelector)
      callback(element, getActionName(element))

  # Attribute buttons

  updateAttributes: (@attributes) ->
    @refreshAttributeButtons()

  refreshAttributeButtons: ->
    @eachAttributeButton (element, attributeName) =>
      element.disabled = @attributes[attributeName] is false
      if @attributes[attributeName] or @dialogIsVisible(attributeName)
        element.setAttribute("data-trix-active", "")
        element.classList.add("trix-active")
      else
        element.removeAttribute("data-trix-active")
        element.classList.remove("trix-active")

  eachAttributeButton: (callback) ->
    for element in @element.querySelectorAll(attributeButtonSelector)
      callback(element, getAttributeName(element))

  applyKeyboardCommand: (keys) ->
    keyString = JSON.stringify(keys.sort())
    for button in @element.querySelectorAll("[data-trix-key]")
      buttonKeys = button.getAttribute("data-trix-key").split("+")
      buttonKeyString = JSON.stringify(buttonKeys.sort())
      if buttonKeyString is keyString
        triggerEvent("mousedown", onElement: button)
        return true
    false

  # Dialogs

  dialogIsVisible: (dialogName) ->
    if element = @getDialog(dialogName)
      element.hasAttribute("data-trix-active")

  toggleDialog: (dialogName) ->
    if @dialogIsVisible(dialogName)
      @hideDialog()
    else
      @showDialog(dialogName)

  showDialog: (dialogName) ->
    @hideDialog()
    @delegate?.toolbarWillShowDialog()

    element = @getDialog(dialogName)
    element.setAttribute("data-trix-active", "")
    element.classList.add("trix-active")

    for disabledInput in element.querySelectorAll("input[disabled]")
      disabledInput.removeAttribute("disabled")

    if dialogName == 'x-color'
      bgColor = @delegate?.currentAttributes?.backgroundColor
      hasColor = false
      for bgColorElement in element.querySelectorAll('input[name=backgroundColor]')
        bgColorElement.checked = (bgColorElement.value == bgColor)
        hasColor = hasColor || bgColorElement.checked

      frontColor = @delegate?.currentAttributes?.foregroundColor
      for frontColorElement in element.querySelectorAll('input[name=foregroundColor]')
        frontColorElement.checked = (frontColorElement.value == frontColor)
        hasColor = hasColor || frontColorElement.checked

      if hasColor
        element.querySelector('.remove_coloring').style.display = 'block'
      else
        element.querySelector('.remove_coloring').style.display = 'none'

    else
      if attributeName = getAttributeName(element)
        if input = getInputForDialog(element, dialogName)
          input.value = @attributes[attributeName] ? ""
          input.select()

    @delegate?.toolbarDidShowDialog(dialogName)

  setAttribute: (dialogElement) ->
    attributeName = getAttributeName(dialogElement)
    input = getInputForDialog(dialogElement, attributeName)
    if input.willValidate and not input.checkValidity()
      input.setAttribute("data-trix-validate", "")
      input.classList.add("trix-validate")
      input.focus()
    else
      @delegate?.toolbarDidUpdateAttribute(attributeName, input.value)
      @hideDialog()

  foregroundColor: (checked, color, dialogElement) ->
    @delegate?.toolbarDidUpdateAttribute('foregroundColor', color)
    @hideDialog()

  backgroundColor: (checked, color, dialogElement) ->
    @delegate?.toolbarDidUpdateAttribute('backgroundColor', color)
    @hideDialog()

  removeAttribute: (dialogElement) ->
    attributeName = getAttributeName(dialogElement)
    @delegate?.toolbarDidRemoveAttribute(attributeName)
    @hideDialog()

  hideDialog: ->
    for element in @element.querySelectorAll(activeDialogSelector)
      element.removeAttribute("data-trix-active")
      element.classList.remove("trix-active")
      @resetDialogInputs()
      @delegate?.toolbarDidHideDialog(getDialogName(element))

  resetDialogInputs: ->
    for input in @element.querySelectorAll(dialogInputSelector)
      input.setAttribute("disabled", "disabled")
      input.removeAttribute("data-trix-validate")
      input.classList.remove("trix-validate")

  getDialog: (dialogName) ->
    @element.querySelector("[data-trix-dialog=#{dialogName}]")

  getInputForDialog = (element, attributeName) ->
    attributeName ?= getAttributeName(element)
    element.querySelector("[data-trix-input][name='#{attributeName}']")

  # General helpers

  getActionName = (element) ->
    element.getAttribute("data-trix-action")

  getAttributeName = (element) ->
    element.getAttribute("data-trix-attribute") ? element.getAttribute("data-trix-dialog-attribute")

  getDialogName = (element) ->
    element.getAttribute("data-trix-dialog")
