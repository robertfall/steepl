window.MessagesController = (params={})->
  this.$bodyTextArea = $('#body-textarea')
  this.$characterCount = $('.character-count')
  this.updatePreview()
  this.registerEventListeners()
  this.renderAttachments = true

window.MessagesController.prototype.registerEventListeners = ->
  that = this
  this.$bodyTextArea.on 'keyup', (e) ->
    that.updatePreview(e)
  this.$bodyTextArea.on 'keyup', (e) ->
    that.updateCharacterCount(e)
  $('#save-and-send-button').on 'click', (e) ->
    that.saveAndSendMessage(e)
  $('#save-button').on 'click', (e) ->
    that.saveMessage(e)
  $('#email_mode, #sms_mode').on 'change', (e) ->
    that.handleModeChange(e)

window.MessagesController.prototype.updatePreview = ->
  if this.renderAttachments
    previewHtml = markdown.toHTML($('#body-textarea').val())
    _.each $('.message-html'), (item) ->
      previewHtml += item.innerHTML
    $('.message-preview').html(previewHtml)
  else
    $('.message-preview').html($('#body-textarea').val())

window.MessagesController.prototype.enableSorting = ->
  $('.metro-list').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

window.MessagesController.prototype.saveAndSendMessage = (e) ->
  $('#message_should_send').val true
  this.saveMessage(e)

window.MessagesController.prototype.saveMessage = ->
  $('#message_form').submit()

window.MessagesController.prototype.updateCharacterCount = ->
  smsLength = 147
  count = this.$bodyTextArea.val().length
  numberOfSms = Math.floor(count/smsLength) + 1
  charactersInLastSms = count % 147
  charactersRemaining = 147 - charactersInLastSms
  characterMessage = "#{charactersRemaining} characters remaining. #{numberOfSms} sms's."
  this.$characterCount.html(characterMessage)

window.MessagesController.prototype.smsMode = ->
  this.renderAttachments = false
  this.updateCharacterCount()
  this.$characterCount.show()
  this.$bodyTextArea.attr('rows', 3)
  $('.attachments-section').hide()
  $('.message-preview-section').hide()

window.MessagesController.prototype.emailMode = ->
  this.renderAttachments = true
  this.$characterCount.hide()
  this.$bodyTextArea.attr('rows', 20)
  $('.attachments-section').show()
  $('.message-preview-section').show()

window.MessagesController.prototype.handleModeChange = (e) ->
  this.emailMode() if $('#email_mode').is(':checked')
  this.smsMode() if $('#sms_mode').is(':checked')
