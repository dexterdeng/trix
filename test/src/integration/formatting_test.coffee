#Text attribute changes
#Block attribute changes
#Applying a link
#Editing a link
#Removing a link
#Current attributes (apply attribute and then type)
#Attribute states are reflected in the toolbar as the selection changes

editorModule "Formatting", template: "editor_empty"

editorTest "applying attributes to text", (done) ->
  typeCharacters "abc", ->
    selectInDirection "left", ->
      clickToolbarButton attribute: "bold", ->
        expectAttributes([0, 2], {})
        expectAttributes([2, 3], bold: true)
        expectAttributes([3, 4], blockBreak: true)
        done()

editorTest "applying a link to text", (done) ->
  typeCharacters "abc", ->
    moveCursor "left", ->
      selectInDirection "left", ->
        clickToolbarButton attribute: "href", ->
          typeInToolbarDialog "http://example.com", attribute: "href", ->
            expectAttributes([0, 1], {})
            expectAttributes([1, 2], href: "http://example.com")
            expectAttributes([2, 3], {})
            done()

editorTest "editing a link", (done) ->
  editor.composition.insertString("a")
  text = Trix.Text.textForStringWithAttributes("bc", href: "http://example.com")
  editor.composition.insertText(text)
  editor.composition.insertString("d")
  moveCursor direction: "left", times: 2, ->
    clickToolbarButton attribute: "href", ->
      assertLocationRange([0,1], [0,3])
      typeInToolbarDialog "http://example.org", attribute: "href", ->
        expectAttributes([0, 1], {})
        expectAttributes([1, 3], href: "http://example.org")
        expectAttributes([3, 4], {})
        done()

editorTest "removing a link", (done) ->
  text = Trix.Text.textForStringWithAttributes("ab", href: "http://example.com")
  editor.composition.insertText(text)
  expectAttributes([0, 2], href: "http://example.com")
  selectInDirection "left", ->
    selectInDirection "left", ->
      clickToolbarButton attribute: "href", ->
        clickToolbarDialogButton method: "removeAttribute", ->
          expectAttributes([0, 2], {})
          done()

editorTest "applying block attributes", (done) ->
  typeCharacters "abc", ->
    clickToolbarButton attribute: "quote", ->
      expectAttributes([0, 4], quote: true)
      done()

# applying block attribute to text with collapsed selection
# applying block attribute to text across newlines using selection
# toggling block attribute from quote to code
# breaking out of a block by pressing return twice

editorTest "applying block attributes to text after newline", (done) ->
  typeCharacters "a\nbc", ->
    clickToolbarButton attribute: "quote", ->
      expectAttributes([0, 1], {})
      expectAttributes([1, 2], blockBreak: true)
      expectAttributes([2, 4], quote: true)
      done()

clickToolbarButton = ({attribute, action}, callback) ->
  button = document.getElementById("toolbar").querySelector(".button[data-attribute='#{attribute}'], .button[data-action='#{action}']")
  triggerEvent(button, "click")
  defer(callback)

clickToolbarDialogButton = ({method}, callback) ->
  button = document.querySelector("#toolbar .dialog input[type=button][data-method='#{method}']")
  triggerEvent(button, "click")
  callback()

typeInToolbarDialog = (string, {attribute}, callback) ->
  dialog = document.getElementById("toolbar").querySelector(".dialog[data-attribute='#{attribute}']")
  input = dialog.querySelector("input[name='#{attribute}']")
  button = dialog.querySelector("input[data-method='setAttribute']")
  input.value = string
  triggerEvent(button, "click")
  defer(callback)

expectAttributes = (range, attributes) ->
  locationRange = editor.document.locationRangeFromRange(range)
  commonAttributes = editor.document.getCommonAttributesAtLocationRange(locationRange)
  deepEqual commonAttributes, attributes