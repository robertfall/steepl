window.MessagesController = (params={})->
  this.registerEventListeners()
  this.updatePreview()

window.MessagesController.prototype.registerEventListeners = ->
  that = this
  $('#body-textarea').on 'keyup', this.updatePreview

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

