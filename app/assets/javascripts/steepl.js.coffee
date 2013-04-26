window.SteeplController = (params={})->
  this.registerEventListeners()
  this

################## Initialization #######################

window.SteeplController.prototype.registerEventListeners = ->
  that = this
  $('.sort-options a').on 'click', ->
    that.applySorting($(this).closest('li'))
    return false

window.SteeplController.prototype.applySorting = ($sortField) ->
  oldDirection = $sortField.data('direction')
  $('.metro-list-item').tsort
    order: oldDirection
    attr: 'data-' + $sortField.data('attr')
  newDirection = if oldDirection == 'asc' then 'desc' else 'asc'
  $sortField.data('direction', newDirection)
