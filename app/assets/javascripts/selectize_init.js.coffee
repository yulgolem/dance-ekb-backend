@initSelectize = ->
  $('select.selectize-basic').selectize({plugins: ['remove_button']})
  $('select.selectize-sortable').selectize({plugins: ['remove_button', 'drag_drop']})
  $('.selectize-multi-create').selectize
    plugins: ['remove_button', 'restore_on_backspace']
    delimiter: ' '
    hideSelected: true
    duplicates: false
    persist: false
    create: (input) ->
      {
        value: "new:#{input}" # use "new:..." to indicate new object
        text: input
      }
  # TODO: fix style with input not association
  $('.selectize-single-create').selectize
    plugins: ['remove_button', 'restore_on_backspace']
    hideSelected: true
    duplicates: false
    persist: false
    create: (input) ->
      {
        value: input
        text: input
      }
