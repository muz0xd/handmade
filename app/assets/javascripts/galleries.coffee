# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).bind 'page:change', ->
  $('.fancybox').fancybox
    type: 'image'
    parent: "body"
    openEffect: 'fade'
    closeEffect: 'fade'
    nextEffect: 'elastic'
    prevEffect: 'elastic'

  $('.show-gallery img').last().load ->
    $pcry = $('.grid').packery
      itemSelector: '.grid-item'
      columnWidth: 330
    $pcry.find('.grid-item').each (i, gridItem) ->
      draggie = new Draggabilly(gridItem)
      $pcry.packery 'bindDraggabillyEvents', draggie

  $('.index-gallery img').last().load ->
    $pcry = $('.grid').packery
      itemSelector: '.grid-item'
      columnWidth: 330
