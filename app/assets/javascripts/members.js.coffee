Handlebars.registerHelper 'nameList', (array, separator) ->
  names = $.map(array, (member) ->
    member.firstName)
  names.join(separator)

window.MembersController = (params={})->
  this.familiesUrl = params['familiesUrl'] if params['familiesUrl']
  this.familyRoles = params['familyRoles'] if params['familyRoles']
  this.familySuggestionTemplate = Handlebars.compile($('#family-suggestion-template').html())
  this.addressSuggestionTemplate = Handlebars.compile($('#address-suggestion-template').html())
  this.familyTemplate = Handlebars.compile($('#family-template').html())
  this.registerEventListeners()
  this.enableRoleTags()
  this.enableFamilyAutoComplete()

window.MembersController.prototype.registerEventListeners = ->
  that = this
  $('#new-family-button').on 'click', (e)->
    e.preventDefault()
    that.newFamily(this)
    return false
  $('.family-details-section').on 'click', '.family-suggestion', (e)->
    e.preventDefault()
    that.selectFamily($(this).data('family-id'))
    return false
  $('.address-suggestions').on 'click', '.quick-fill-address', (e)->
    e.preventDefault()
    that.fillAddress(this)
    return false
  $('#form_last_name').on 'blur', ->
    that.requestFamilies($(this).val())
  $('body').on 'blur', '.capitalize', ->
    $(this).val(_.str.titleize($(this).val()))
  $('body').on 'click', '.remove-telephone', ->
    $(this).closest('.telephone-container').remove()
    return false
  unless ( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent))
    $('.dialing-code').on 'keyup', ->
      $dialingCode = $(this)
      $dialingCode.siblings('.number').focus().click() if ($dialingCode.val().length >= 3)

window.MembersController.prototype.enableRoleTags = ->
  $('.family-roles').tagit
    availableTags: this.familyRoles
    placeholderText: 'Family Roles'

  $('.tagit').on 'focus', 'input[type="text"]', ->
    $(this).closest('.tagit').addClass('focus')
  $('.tagit').on 'blur', 'input[type="text"]', ->
    $(this).closest('.tagit').removeClass('focus')

window.MembersController.prototype.enableFamilyAutoComplete = ->
  that = this
  $( ".family-name" ).autocomplete
    source: (request, response) ->
      $.getJSON that.familiesUrl, { q: request.term }, (data)->
        that.families = data
        response $.map data, ( item ) ->
            label: item.name
            value: item.id
    select: (event, ui) ->
      $(this).closest('.family-details').remove()
      that.selectFamily(ui.item.value)

window.MembersController.prototype.newFamily = (sender)->
  id = time = new Date().getTime()
  $('.family-details-section').append this.familyTemplate
    id: id
    familyName: $('#form_last_name').val()
  this.clearFamilySuggestions()
  this.enableRoleTags()
  this.enableFamilyAutoComplete()

window.MembersController.prototype.selectFamily = (familyId)->
  selectedFamily = _.find(this.families, (family) ->
    family.id == familyId
  )
  id = new Date().getTime()
  $('.family-details-section').append this.familyTemplate
      id: id
      familyName: selectedFamily.name
      familyId: selectedFamily.id

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
  thing = (memo, address) ->
    memo.push(address) unless _.any(memo, ((y) -> y != address && _.isEqual(y, address)))
    memo
  addresses = _.inject(addresses, thing, [])
  _.each addresses, (address)->
    $('.address-suggestions').append(that.addressSuggestionTemplate(address))

window.MembersController.prototype.requestFamilies = (searchTerm) ->
  return unless searchTerm.length > 0
  that = this
  $.get that.familiesUrl + '?q=' + searchTerm, (data)->
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
