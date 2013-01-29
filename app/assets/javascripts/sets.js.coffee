jQuery ->
  $('#songs').sortable
    axis: 'y'
    update: ->
      alert 'updated!'

