jQuery ->
  fixHelper = (e, ui) ->
    ui.children().each ->
      $(this).width($(this).width())
    return ui
  $('#songs').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
    helper: fixHelper
    forceHelperSize: true

