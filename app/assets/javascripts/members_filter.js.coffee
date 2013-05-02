window.MembersFilterController = (params={})->
  this.memberTemplate = Handlebars.compile($('#member-template').html())
  this.loadingTemplate = Handlebars.compile($('#loading-template').html())
  this.membersUrl = params.membersUrl
  this.membersJsonUrl = params.membersJsonUrl
  this.minAgeLimit = params.minAgeLimit
  this.maxAgeLimit = params.maxAgeLimit
  this.minAge = params.minAge
  this.maxAge = params.maxAge
  this.registerEventListeners()
  this.$membersList = $('.members-list')
  this.captureInitialState()
  this

################## Initialization #######################

window.MembersFilterController.prototype.registerEventListeners = ->
  that = this
  $('.page-content').on 'click', '.filter-option', ->
    $(this).toggleClass 'active'
  $('.page-content').on 'click', '.filter-option', ->
    that.updateFacetForOption($(this))
  $('.page-content').on 'keydown', '.filter-field', ->
    that.startFilterTimer()
  $('.page-content').on 'blur', '.datepicker.filter-field', ->
    that.startFilterTimer()
  window.onpopstate = (event) ->
    that.popState(event)
  $('.page-content').on 'click', '.hide-filter', ->
    $('.filter-form-content').slideToggle()
    return false

window.MembersFilterController.prototype.startFilterTimer = ->
  console.log('Starting filter timer')
  that = this
  this.$membersList.empty().append(this.loadingTemplate())
  clearTimeout this.timer if this.timer
  this.timer = setTimeout ->
      that.applyFilter()
    , 500

window.MembersFilterController.prototype.popState = (event) ->
  return if (event.state == null)
  this.$membersList = $('.members-list')
  $('.page-content').html(event.state.content)
  $("#age-slider").editRangeSlider('destroy')

window.MembersFilterController.prototype.captureInitialState = ->
  setTimeout ->
    history.replaceState(
      content: $('.page-content').html()
    null, null) if (typeof(history.replaceState) != "undefined")
  , 300

window.MembersFilterController.prototype.applyFilter = ->
  that = this
  $form = $('.filter-form form :input[value!=""]')
  $.ajax
    type: 'GET'
    url: that.membersJsonUrl
    data: $form.serialize()
    complete: ->
      that.updateHistory(that.membersUrl + "?" + decodeURIComponent($form.serialize()))
    success: (data) ->
      that.handleMembersResponse(data)


window.MembersFilterController.prototype.updateHistory = (url) ->
  window.history.pushState(
    content: $('.page-content').html()
  null, url)

window.MembersFilterController.prototype.handleMembersResponse = (data) ->
  that = this
  members = ''
  _.each data, (member) ->
    members += that.memberTemplate(member)
  this.$membersList.empty().append(members)
  $("#matching-count").text("(#{data.length} matching)")

window.MembersFilterController.prototype.updateFacetForOption = ($option) ->
  $parent = $option.closest('.filter-group')
  selectedOptions = _.map $parent.find('.filter-option.active'), ($activeOption) ->
    $activeOption.innerText
  $parent.find('input[type="hidden"]').val(selectedOptions.join(', '))
  this.startFilterTimer()
