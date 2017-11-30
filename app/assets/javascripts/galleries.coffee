# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).bind 'page:change', ->

  Packery::getShiftPositions = (attrName) ->
    attrName = attrName or 'id'
    _this = this
    @items.map (item) ->
      {
        attr: item.element.getAttribute(attrName)
        x: item.rect.x / _this.packer.width
      }

  Packery::initShiftLayout = (positions, attr) ->
    if !positions
      # if no initial positions, run packery layout
      @layout()
      return
    # parse string to JSON
    if typeof positions == 'string'
      try
        positions = JSON.parse(positions)
      catch error
        console.error 'JSON parse error: ' + error
        @layout()
        return
    attr = attr or 'id'
    # default to id attribute
    @_resetLayout()
    # set item order and horizontal position from saved positions
    @items = positions.map(((itemPosition) ->
      selector = '[' + attr + '="' + itemPosition.attr + '"]'
      itemElem = @element.querySelector(selector)
      item = @getItem(itemElem)
      item.rect.x = itemPosition.x * @packer.width
      item
    ), this)
    @shiftLayout()

  $('.fancybox').fancybox
    type: 'image'
    parent: "body"
    openEffect: 'fade'
    closeEffect: 'fade'
    nextEffect: 'elastic'
    prevEffect: 'elastic'

  $('.show-gallery img').last().load ->
    if $('.show-admin-gallery').length
      $pcry = $('.grid').packery
        itemSelector: '.grid-item'
        columnWidth: 330
        initLayout: false

      initPositions = $('#gallery-order').val()

      $pcry.packery 'initShiftLayout', initPositions, 'data-item-id'

      $pcry.find('.grid-item').each (i, gridItem) ->
        draggie = new Draggabilly(gridItem)
        $pcry.packery 'bindDraggabillyEvents', draggie

      $pcry.on 'dragItemPositioned', ->
        positions = $pcry.packery('getShiftPositions', 'data-item-id')
        $('#gallery-order').val JSON.stringify(positions)
    else
      $pcry = $('.grid').packery
        itemSelector: '.grid-item'
        columnWidth: 330
        initLayout: false

      initPositions = $('#gallery-order').val()

      $pcry.packery 'initShiftLayout', initPositions, 'data-item-id'

  $('.index-gallery img').last().load ->
    $pcry = $('.grid').packery
      itemSelector: '.grid-item'
      columnWidth: 330
