@initNestedSortable = ->
  sortable_groups = $('.nested-sortable:not(.initialized)')
  if sortable_groups.length
    sortable_groups.sortable
      cursor: '-webkit-grabbing'
      axis: 'y'
      handle: '.move'
      items: '.nested-fields'
      sort: (e, ui) ->
        ui.item.addClass('dragged-item')
      stop: (e, ui) ->
        ui.item.removeClass('dragged-item')
        # highlight the row on drop to indicate an update
        ui.item.effect('highlight', {}, 1000)
      update: (e, ui) ->
        $(this).children(".nested-fields").each (index) ->
          $(this).find('input.priority-input').val(index + 1)

    sortable_groups.on('cocoon:after-insert', ->
      $('.nested-sortable').children(".nested-fields").each (index) ->
        $(this).find('input.priority-input').val(index + 1)
    )

    sortable_groups.addClass('initialized')

$ ->
  initNestedSortable()

  $('.collapse-control').click ->
    console.log('click')
    $('.is-collapsible').toggle()

  #  if $('.nested-sortable').length
  #    dragging = false
  #    $(".move").mousedown ->
  #      $container = $(this).closest(".nested-sortable")
  #      dragging = true
  #      $container.css(overflow: 'auto')
  #    $(document).mouseup ->
  #      if dragging
  #        dragging = false
  #        $(".nested-sortable").css(overflow: 'visible')

  if $('.table-sortable').length && window.enableSort
# Return a helper with preserved width of cells
    fixHelper = (e, ui) ->
      ui.children().each ->
        $(this).width $(this).width()
        return
      ui

    $('.table-sortable tbody').sortable
      cursor: '-webkit-grabbing'
      axis: 'y'
      helper: fixHelper
      sort: (e, ui) ->
        ui.item.addClass('dragged-item')
      stop: (e, ui) ->
        ui.item.removeClass('dragged-item')
        # highlight the row on drop to indicate an update
        ui.item.children('td').effect('highlight', {}, 1000)
      update: (e, ui) ->
        item_id = ui.item.data('item-id')
        $table = ui.item.closest('table')
        resourceType = $table.data('items-type')
        positionField = $table.data('items-position-field')
        console.log ui.item
        position = ui.item.index()
        console.log(item_id, position)
        $priorityEl = ui.item.find('.priority-field')
        data = {}
        data[resourceType] = {}
        data[resourceType][positionField] = position
        $.ajax(
          type: 'PATCH'
          url: window.location.pathname+'/'+item_id+'.json?sort=1'
          dataType: 'json'
          data: data
        ).done(
          (data) =>
            $priorityEl.replaceWith('<span class="priority-field">' + data.priority + '</span>')
        )

