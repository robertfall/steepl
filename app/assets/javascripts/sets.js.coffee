jQuery ->
  fixHelper = (e, ui) ->
    ui.children().each ->
      $(this).width($(this).width())
    return ui
  $('.metro-list').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  #setInterval ->
   # $('.preview').html(markdown.toHTML($('.blurb').val()))
  #300
  $('.archive-toggle').on 'click', ->
    $('.archived').toggle()
    return false
