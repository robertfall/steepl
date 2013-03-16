Handlebars.registerHelper 'nameList', (array, separator) ->
  names = $.map(array, (member) ->
    member.firstName)
  names.join(separator)

window.MembersController = (params={})->
  this.familiesUrl = params['familiesUrl'] if params['familiesUrl']
  this.familyRoles = params['familyRoles'] if params['familyRoles']
  this.familySuggestionTemplate = Handlebars.compile($('#family-suggestion-template').html())
  this.addressSuggestionTemplate = Handlebars.compile($('#address-suggestion-template').html())
  this.newFamilyTemplate = Handlebars.compile($('#new-family-template').html())
  this.existingFamilyTemplate = Handlebars.compile($('#existing-family-template').html())
  this.registerEventListeners()

window.MembersController.prototype.registerEventListeners = ->
  that = this
  $('#new-family-button').on 'click', ->
    that.newFamily(this)
  $('.family-details-section').on 'click', '.family-suggestion', ->
    that.selectFamily(this)
  $('.address-suggestions').on 'click', '.quick-fill-address', ->
    that.fillAddress(this)
  $('#form_last_name').on 'blur', ->
    that.requestFamilies()
  $('.dialing-code').on 'keyup', ->
    $dialingCode = $(this)
    $dialingCode.siblings('.number').focus() if ($dialingCode.val().length >= 3)


window.MembersController.prototype.enableRoleTags = ->
  $('.family-roles').tagit
    availableTags: this.familyRoles
  $('.tagit').on 'focus', 'input[type="text"]', ->
    $(this).closest('.tagit').addClass('focus')
  $('.tagit').on 'blur', 'input[type="text"]', ->
    $(this).closest('.tagit').removeClass('focus')

window.MembersController.prototype.newFamily = (sender)->
  id = time = new Date().getTime()
  $('.family-details-section').append this.newFamilyTemplate
    id: id
    familyName: $('#form_last_name').val()
  this.clearFamilySuggestions()
  this.enableRoleTags()

window.MembersController.prototype.selectFamily = (sender)->
  $familySuggestion = $(sender)
  selectedFamily = _.find(this.families, (family) ->
    family.id == $familySuggestion.data('family-id')
  )
  id = new Date().getTime()
  $('.family-details-section').append this.existingFamilyTemplate
      id: id
      familyName: $familySuggestion.data 'family-name'
      familyId: $familySuggestion.data 'family-id'

  this.fillAddressSuggestions(selectedFamily)
  this.clearFamilySuggestions()
  this.enableRoleTags()

window.MembersController.prototype.fillAddressSuggestions = (family) ->
  that = this
  addresses = _.flatten _.map family.members, (member) ->
    _.map member.addresses, (address) ->
     fullAddress:
       [address.address1, address.address2, address.city, address.postalCode].join(', ')
      address1: address.address1
      address2: address.address2
      city: address.city
      postalCode: address.postalCode
  _.each addresses, (address)->
    $('.address-suggestions').append(that.addressSuggestionTemplate(address))

window.MembersController.prototype.requestFamilies = ->
  that = this
  $.get that.familiesUrl, (data)->
    that.handleFamilies data

window.MembersController.prototype.handleFamilies = (data) ->
  this.families = data
  $('.family-suggestions').empty()
  that = this
  $.each this.families, (index, family) ->
    $('.family-suggestions').append(that.familySuggestionTemplate(family))

window.MembersController.prototype.fillAddress = (addressSuggestion) ->
  $suggestion = $(addressSuggestion)
  $address = $suggestion.closest('.address')
  _.each ['address1', 'address2', 'city', 'postalCode'], (field) ->
    $address.find('.' + field).val($suggestion.data(field.toLowerCase()))

window.MembersController.prototype.clearFamilySuggestions = ->
  $('.family-suggestions-section').remove()
