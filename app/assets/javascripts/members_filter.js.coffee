window.MembersFilterController = (params={})->
  this.memberTemplate = Handlebars.compile($('#member-template').html())
  this.loadingTemplate = Handlebars.compile($('#loading-template').html())
  this.membersUrl = params.membersUrl
  this.minAgeLimit = params.minAgeLimit
  this.maxAgeLimit = params.maxAgeLimit
  this.minAge = params.minAge
  this.maxAge = params.maxAge
  this.enableSlider()
  this.registerEventListeners()
  this.$membersList = $('.members-list')
  this

################## Initialization #######################

window.MembersFilterController.prototype.registerEventListeners = ->
  that = this
  $('#age-slider').on 'valuesChanged', (e, data) ->
    that.sliderChanged(data)
  $('.filter-options').on 'click', '.filter-option', ->
    $(this).toggleClass 'active'
  $('.filter-form').on 'submit', ->
    $('.ui-editRangeSlider-inputValue').remove()
  $('.filter-form').on 'click', '.filter-option', ->
    that.updateFacetForOption($(this))
  $('.filter-field').on 'blur', ->
    that.startFilterTimer()
  $('.filter-field').on 'keydown', ->
    that.startFilterTimer()
  $('.hide-filter').on 'click', ->
    $('.filter-form-content').slideToggle()
    return false

window.MembersFilterController.prototype.sliderChanged = (data) ->
  $('#age_min_hidden').val data.values.min
  $('#age_max_hidden').val data.values.max
  this.startFilterTimer()

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

window.MembersFilterController.prototype.startFilterTimer = ->
  console.log('Starting filter timer')
  that = this
  this.$membersList.empty().append(this.loadingTemplate())
  clearTimeout this.timer if this.timer
  this.timer = setTimeout ->
      that.applyFilter()
    , 500


window.MembersFilterController.prototype.applyFilter = ->
  that = this
  $form = $('.filter-form form')
  $.ajax
    type: 'GET'
    url: this.membersUrl
    data: $form.serialize()
    success: (data) ->
      that.handleMembersResponse(data)

window.MembersFilterController.prototype.handleMembersResponse = (data) ->
  that = this
  members = ''
  _.each data, (member) ->
    members += that.memberTemplate(member)
  this.$membersList.empty().append(members)

window.MembersFilterController.prototype.updateFacetForOption = ($option) ->
  $parent = $option.closest('.filter-group')
  selectedOptions = _.map $parent.find('.filter-option.active'), ($activeOption) ->
    $activeOption.innerText
  $parent.find('input[type="hidden"]').val(selectedOptions.join(', '))
  this.startFilterTimer()
