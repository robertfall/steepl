window.MembersFilterController = (params={})->
  this.minAgeLimit = params.minAgeLimit
  this.maxAgeLimit = params.maxAgeLimit
  this.minAge = params.minAge
  this.maxAge = params.maxAge
  this.enableSlider()
  this.registerEventListeners()

################## Initialization #######################

window.MembersFilterController.prototype.registerEventListeners = ->
  that = this
  $('#age-slider').on 'valuesChanged', (e, data) ->
    $('#age_min_hidden').val data.values.min
    $('#age_max_hidden').val data.values.max
  $('.filter-options').on 'click', '.filter-option', ->
    $(this).toggleClass 'active'
  $('.filter-form').on 'submit', ->
    $('.ui-editRangeSlider-inputValue').remove()
  $('.filter-form').on 'click', '.filter-option', ->
    that.updateFacetForOption($(this))

window.MembersFilterController.prototype.enableSlider = ->
  $("#age-slider").editRangeSlider
    arrows: false
    step: 1
    bounds:
      min: this.minAgeLimit
      max: this.maxAgeLimit
    defaultValues:
      min: this.minAge
      max: this.maxAge

window.MembersFilterController.prototype.updateFacetForOption = ($option) ->
  $parent = $option.closest('.filter-group')
  selectedOptions = _.map $parent.find('.filter-option.active'), ($activeOption) ->
    $activeOption.innerText
  $parent.find('input[type="hidden"]').val(selectedOptions.join(', '))
