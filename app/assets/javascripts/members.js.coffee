window.clearFamilySuggestions = ->
  $('.family-suggestions-section').remove()
$ ->
    newFamilyTemplate = Handlebars.compile($('#new-family-template').html())
    existingFamilyTemplate = Handlebars.compile($('#existing-family-template').html())
    $('#new-family-button').on 'click', ->
      $('.family-details-section').append(newFamilyTemplate())
      clearFamilySuggestions()

    $('.family-details-section').on 'click', '.family-suggestion', ->
      $familySuggestion = $(this)
      $('.family-details-section').append existingFamilyTemplate
          familyName: $familySuggestion.data 'family-name'
          familyId: $familySuggestion.data 'family-id'
      clearFamilySuggestions()


