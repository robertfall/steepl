window.MembersController = ->
  this.newFamilyTemplate = Handlebars.compile($('#new-family-template').html())
  this.existingFamilyTemplate = Handlebars.compile($('#existing-family-template').html())
  this.registerEventListeners()

window.MembersController.prototype.registerEventListeners = ->
  that = this
  $('#new-family-button').on 'click', ->
    that.renderNewFamilyTempate(this)
  $('.family-details-section').on 'click', '.family-suggestion', ->
    that.renderExistingFamilyTempate(this)

window.MembersController.prototype.renderNewFamilyTempate = (sender)->
  id = time = new Date().getTime()
  $('.family-details-section').append(this.newFamilyTemplate({id: id}))
  this.clearFamilySuggestions()

window.MembersController.prototype.renderExistingFamilyTempate = (sender)->
  $familySuggestion = $(sender)
  id = time = new Date().getTime()
  $('.family-details-section').append this.existingFamilyTemplate
      id: id
      familyName: $familySuggestion.data 'family-name'
      familyId: $familySuggestion.data 'family-id'
  this.clearFamilySuggestions()

window.MembersController.prototype.clearFamilySuggestions = ->
  $('.family-suggestions-section').remove()

$ ->
  window.membersController = new MembersController()
