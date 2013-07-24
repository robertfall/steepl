window.MessagesController = (params={})->
  this.registerEventListeners()
  this.updatePreview()

window.MessagesController.prototype.registerEventListeners = ->
  that = this
  $('#body-textarea').on 'keyup', this.updatePreview
  $('#save-and-send-button').on 'click', (e) ->
    that.saveAndSendMessage(e)
  $('#save-button').on 'click', (e) ->
    that.saveMessage(e)

window.MessagesController.prototype.updatePreview = ->
  previewHtml = markdown.toHTML($('#body-textarea').val())
  _.each $('.message-html'), (item) ->
    previewHtml += item.innerHTML
  $('.message-preview').html(previewHtml)

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

