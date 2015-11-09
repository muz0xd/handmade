# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).bind 'page:change', ->
  $('.post_textarea').froalaEditor
    imageUploadURL: '/attachment/image/download'
    imageUploadParams: id: 'image'
    heightMin: 300
  .on 'froalaEditor.image.removed', (e, editor, $img) ->
      $.ajax(
        method: 'POST'
        url: '/attachment/image/destroy'
        data: src: $img.attr('src')).done((data) ->
        console.log 'image was deleted'
        return
      ).fail ->
        console.log 'image delete problem'
