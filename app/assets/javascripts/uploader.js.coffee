$ ->
  re = /(?:\.([^.]+))?$/
  source   = $("#progressBar").html()
  window.tmpl = Handlebars.compile(source)
  window.attachment = Handlebars.compile($("#attachment").html())
  $('#fileupload').fileupload
    dropZone: $('.dropZone')
    add: (e, data) ->
       data.context = $(tmpl(data.files[0]))
       $('.uploadSection').append(data.context)
       data.submit()
    progress: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      data.context.find('.bar').css(width: "#{progress}%") if data.context
    done: (e, data) =>
      file = data.files[0]
      to = $('#fileupload').data('post')
      domain = $('#fileupload').attr('action')
      path = $('#fileupload input[name=key]').val().replace('${filename}', file.name)
      content = {}
      address = domain + path
      content[$('#fileupload').data('as')] = address
      $.post(to, content)
      data.context.remove() if data.context
      newAttachment = attachment
        fileName: file.name.substr(0, file.name.lastIndexOf('.'))
        fileUrl: address
        fileType: file.name.substr(file.name.lastIndexOf('.'))
      $('.table').append($(newAttachment))


$(document).bind 'dragover', (e) ->
    dropZone = $('.dropZone')
    timeout = window.dropZoneTimeout

    if !timeout
      dropZone.addClass('in')
    else
      clearTimeout(timeout)

    if e.target == dropZone[0]
      dropZone.addClass('hover')
    else
      dropZone.removeClass('hover');

    window.dropZoneTimeout = setTimeout( ->
        window.dropZoneTimeout = null
        dropZone.removeClass('in hover')
      ,100)
