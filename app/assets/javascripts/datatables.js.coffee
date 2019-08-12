@initOfflineFormDatatable = (table_el) ->
  # prepare sorting rules array
  column_count = table_el.find('thead tr th').length
  column_sorting_rule = Array(column_count)
  column_sorting_rule[0] = orderable: true
  column_sorting_rule.fill { orderable: false }, 1

  # create footer with js to not mess with admino constructor
  table_el.append '<tfoot>' + table_el.find('thead')[0].innerHTML + '</tfoot>'

  # TODO: use https://datatables.net/examples/basic_init/complex_header.html
  # to group formal/meaningful assessment columns
  # so need to replace admino builder?(

  window.table = table_el.DataTable(
    scrollX: true
    lengthMenu: [
      [100, 250, 500, -1]
      [100, 250, 500, 'All']
    ]
    select:
      style: 'os'
    columns: column_sorting_rule
    dom: 'Bflrtip'
    stateSave: true
    buttons: [
      {
        extend: 'selected'
        text: 'Выбрать экспертов для проверки'
        action: (e, dt, node, config) ->
          offline_form_ids = []
          $.map dt.rows('.selected').nodes(), (item) ->
            offline_form_ids.push $(item).data('item-id')
          $('.assign_assessment_offline_form_ids input').val offline_form_ids
          # note that if sets string of csv instead of array
          formal_assessment_modal = $('#formal-assessment-assign')
          formal_assessment_modal.modal(
            autofocus: false
            onDeny: ->
              location.reload()
            onHide: ->
              # deselect values on modal close
              formal_assessment_modal.find('select').each ->
                $(this).dropdown 'clear'
          ).modal 'show'
      }
      'colvis'
      'copy'
      'csv'
#      'print'
    ]
    initComplete: ->
      @api().columns().every ->
        column = this
        footer = $(column.footer()).empty()
        column_role = @footer().getAttribute('role')
        if column_role == 'id' or
            column_role == 'actions' or
            column_role == 'formal-assessment-details' or
            column_role == 'meaningful-assessment-details' or
            column_role == 'full-name' or
            column_role == 'email' or
            column_role == null
          # removes filter on selected role values, empty cells left
        else
          select = $('<select><option value="NO_FILTER">показать все</option></select>').appendTo(footer)
          select.on 'change', ->
            val = $.fn.dataTable.util.escapeRegex($(this).val())
            if val == 'NO_FILTER'
              column.search('', true, false).draw()
            else if val == ''
              column.search('^$', true, false).draw()
            else
              column.search('^' + val + '$', true, false).draw()
          column.data().unique().sort().each (d, j) ->
            if column.search() == '^' + d + '$'
              select.append '<option value="' + d + '" selected="selected">' + d + '</option>'
            else
              select.append '<option value="' + d + '">' + d + '</option>'
  )

  # try to fix table misalignment
  # still not working good on vertical resize, footer cells miscalculated
  window.table.fixedHeader.adjust()
  window.table.columns.adjust()
  # still datatables breaks in many aspects on vertical-narrow screens

  # bind ESC key to deselect rows
  $(document).keyup (e) ->
    if e.keyCode == 27
      window.table.rows('.selected').deselect()

  # move footer to top
  $('.dataTables_scrollFoot').each ->
    $(this).insertAfter $(this).parent().find('.dataTables_scrollHead')

# generated with help of js2coffee 2.2.0