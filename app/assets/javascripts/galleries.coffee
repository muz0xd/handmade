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

  # Only after last image loading
  # masenry will be able to correctly set grid height attr
  # it needs for correctly after div viewing
  $('.show-gallery img').last().load ->
    $('.grid').masonry
      itemSelector: '.grid-item'
      isFitWidth: true
      columnWidth: 330

  $('.index-gallery img').last().load ->
    $('.grid').masonry
      itemSelector: '.grid-item'
      isFitWidth: true
      columnWidth: 330
