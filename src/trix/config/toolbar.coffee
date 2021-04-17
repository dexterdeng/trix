Trix.config.toolbar =
  getDefaultHTML: ->
    {lang} = Trix.config
    """
    <div class="trix-button-row">
      <span class="trix-button-group trix-button-group--text-tools" data-trix-button-group="text-tools">
        <button type="button" class="trix-button trix-button--icon trix-button--icon-bold" data-trix-attribute="bold" data-trix-key="b" title="#{lang.bold}" tabindex="-1">#{lang.bold}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-italic" data-trix-attribute="italic" data-trix-key="i" title="#{lang.italic}" tabindex="-1">#{lang.italic}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-strike" data-trix-attribute="strike" title="#{lang.strike}" tabindex="-1">#{lang.strike}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-link" data-trix-attribute="href" data-trix-action="link" data-trix-key="k" title="#{lang.link}" tabindex="-1">#{lang.link}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-color" data-trix-action="x-color" title="Color" tabindex="-1">Color</button>
      </span>

      <span class="trix-button-group trix-button-group--block-tools" data-trix-button-group="block-tools">
        <button type="button" class="trix-button trix-button--icon trix-button--icon-heading-1" data-trix-attribute="heading1" title="#{lang.heading1}" tabindex="-1">#{lang.heading1}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-quote" data-trix-attribute="quote" title="#{lang.quote}" tabindex="-1">#{lang.quote}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-code" data-trix-attribute="code" title="#{lang.code}" tabindex="-1">#{lang.code}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-bullet-list" data-trix-attribute="bullet" title="#{lang.bullets}" tabindex="-1">#{lang.bullets}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-number-list" data-trix-attribute="number" title="#{lang.numbers}" tabindex="-1">#{lang.numbers}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-decrease-nesting-level" data-trix-action="decreaseNestingLevel" title="#{lang.outdent}" tabindex="-1">#{lang.outdent}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-increase-nesting-level" data-trix-action="increaseNestingLevel" title="#{lang.indent}" tabindex="-1">#{lang.indent}</button>
      </span>

      <span class="trix-button-group trix-button-group--file-tools" data-trix-button-group="file-tools">
        <button type="button" class="trix-button trix-button--icon trix-button--icon-attach" data-trix-action="attachFiles" title="#{lang.attachFiles}" tabindex="-1">#{lang.attachFiles}</button>
      </span>

      <span class="trix-button-group-spacer"></span>

      <span class="trix-button-group trix-button-group--history-tools" data-trix-button-group="history-tools">
        <button type="button" class="trix-button trix-button--icon trix-button--icon-undo" data-trix-action="undo" data-trix-key="z" title="#{lang.undo}" tabindex="-1">#{lang.undo}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-redo" data-trix-action="redo" data-trix-key="shift+z" title="#{lang.redo}" tabindex="-1">#{lang.redo}</button>
      </span>
    </div>

    <div class="trix-dialogs" data-trix-dialogs>

      <div class="trix-dialog trix-dialog--link" data-trix-dialog="href" data-trix-dialog-attribute="href">
        <div class="trix-dialog__link-fields">
          <input type="url" name="href" class="trix-input trix-input--dialog" placeholder="#{lang.urlPlaceholder}" aria-label="#{lang.url}" required data-trix-input>
          <div class="trix-button-group">
            <input type="button" class="trix-button trix-button--dialog" value="#{lang.link}" data-trix-method="setAttribute">
            <input type="button" class="trix-button trix-button--dialog" value="#{lang.unlink}" data-trix-method="removeAttribute">
          </div>
        </div>
      </div>


      <div class="trix-dialog trix-dialog--color centered " data-trix-dialog="x-color" >
        <div>
          <bc-color-picker class="color-picker color-picker--for-text color-picker--for-text-foreground" name="foregroundColor" color="#887626 #B95E06 #CF0000 #D81CAA #9013FE #0562B9 #118A0F #945216 #666666">
            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#887626">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #887626; color: #887626"></span>
            </label>

            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#B95E06">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #B95E06; color: #B95E06"></span>
            </label>

            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#CF0000">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #CF0000; color: #CF0000"></span>
            </label>
            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#D81CAA">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #D81CAA; color: #D81CAA"></span>
            </label>

            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#9013FE">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #9013FE; color: #9013FE"></span>
            </label>
            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#0562B9">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #0562B9; color: #0562B9"></span>
            </label>

            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#118A0F">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #118A0F; color: #118A0F"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#945216">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #945216; color: #945216"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="foregroundColor" value="#666666">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #666666; color: #666666"></span>
            </label>
          </bc-color-picker>
        </div>

        <div class="push_quarter--top">
          <bc-color-picker class="color-picker color-picker--for-text color-picker--for-text-background" name="backgroundColor" color="#FAF785 #FFF0DB #FFE5E5 #FFE4F7 #F2EDFF #E1EFFC #E4F8E2 #EEE2D7 #F2F2F2">
            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#FAF785">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #FAF785; color: #FAF785"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#FFF0DB">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #FFF0DB; color: #FFF0DB"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#FFE5E5">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #FFE5E5; color: #FFE5E5"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#FFE4F7">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #FFE4F7; color: #FFE4F7"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#F2EDFF">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #F2EDFF; color: #F2EDFF"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#E1EFFC">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #E1EFFC; color: #E1EFFC"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#E4F8E2">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #E4F8E2; color: #E4F8E2"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#EEE2D7">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #EEE2D7; color: #EEE2D7"></span>
            </label>


            <label class="color-picker__field" data-role="color_picker_field">
              <input class="color-picker__input" data-role="color_picker_input" type="radio" name="backgroundColor" value="#F2F2F2">
              <span class="color-picker__swatch" data-role="color_picker_swatch" style="background-color: #F2F2F2; color: #F2F2F2"></span>
            </label>
          </bc-color-picker>
        </div>

        <div class="push_quarter--top color_dialog__hide-unless-selection-contains-coloring">
          <button type="button" class="remove_coloring" data-behavior="remove_coloring">清除颜色</button>
        </div>
      </div>


    </div>
    """
