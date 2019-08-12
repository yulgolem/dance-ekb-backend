#@hideFields = (element) ->
#  element.hide()
#  element.addClass('hidden')
#  buttons = $(".ui.button.collapse-block-element-control")
#  hideButton(buttons)
#
#@hideFieldItems = (element) ->
#  element.hide()
#  element.addClass('hidden')
#  buttons = $(".ui.button.collapse-block-element-item-control")
#  hideButton(buttons)
#
#@showFields = (element) ->
#  element.show()
#  element.removeClass('hidden')
#  buttons = $(".ui.button.collapse-block-element-control")
#  showButton(buttons)
#
#@showFieldItems = (element) ->
#  element.show()
#  element.removeClass('hidden')
#  buttons = $(".ui.button.collapse-block-element-item-control")
#  showButton(buttons)

#@initMap = (root_selector = 'form') ->
#  $('.address-preview:not(.initialized)').each (index) ->
#    $preview = $(this)
#    $preview.addClass 'initialized'
#    $nested_root = $preview.closest(root_selector)
#    $preview.locationpicker
#      radius: 0
#      location:
#        latitude: Number($nested_root.find('.lat-input').val())
#        longitude: Number($nested_root.find('.lng-input').val())
#      inputBinding:
#        latitudeInput: $nested_root.find('.lat-input')
#        longitudeInput: $nested_root.find('.lng-input')
#        locationNameInput: $nested_root.find('.address-input')
##      markerInCenter: true, - disabled as this breaks autocomplete
#      enableAutocomplete: true
#      enableAutocompleteBlur: true
#      enableReverseGeocode: false

@initFormalAssessmentForm = () ->
  comment = $('#offline_formal_assessment_assessment_comment')[0]
  $('.offline_formal_assessment_assessment_result input.semantic_ui_radio_buttons').each ->
    this.addEventListener 'change', ->
      if (this.value == 'declined')
        if (this.checked)
          comment.removeAttribute('disabled');
          comment.classList.remove('disabled');
          comment.closest('.field').classList.remove('disabled');
        else
          comment.setAttribute('disabled', 'disabled');
          comment.classList.add('disabled');
          comment.closest('.field').classList.add('disabled');
      else
        comment.setAttribute('disabled', 'disabled');
        comment.classList.add('disabled');
        comment.closest('.field').classList.add('disabled');

@initComponents = () ->
#  checkAllButtons()
  initSelectize()
  $('.dropdown').dropdown('refresh')
  $('.ui.calendar').calendar
    ampm: false
    firstDayOfWeek: 1
  $('.ui.calendar.date').calendar
    ampm: false
    type: 'date'
    firstDayOfWeek: 1
# TODO does not work for some reason
#      text:
#        days: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб']
#        months: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
#        monthsShort: ['Янв', 'Фев', 'Март', 'Апр', 'Май', 'Июнь', 'Июль', 'Авг', 'Сен', 'Окт', 'Нояб', 'Дек']
#        today: 'Сегодня'
#        now: 'Сейчас'
#        am: 'AM'
#        pm: 'PM'

@flashMessageTimeout = () ->
  flashTimeout = setTimeout (->
    $('#flash-message .message').fadeOut 'slow'
    return
  ), 10000

$ ->
#  $(document).on('click', '.address-preview-disabler', (e) ->
#    $(this).hide()
#  )

#  $('.ui.dropdown.with-additions').dropdown(
#    allowAdditions: true,
#    fullTextSearch: 'exact'
#  )

#  enable popups, use specified class
#  $('.with-popup').each ->
#    $(this).popup()

  initComponents

  $('.ui.dropdown').dropdown(
    fullTextSearch: true
  )

  $('.ui.calendar').calendar
    ampm: false
    firstDayOfWeek: 1

  $('.ui.calendar.date').calendar
    ampm: false
    type: 'date'
    firstDayOfWeek: 1

  $('.table-admino.sortable').tablesort()

  $("form").on("keypress", (e) ->
    if (e.keyCode == 13 && !$(this).hasClass('submit-on-enter'))
      unless $(e.target).is('textarea')
        return false
  )

  flashMessageTimeout

#  $('.menu.form-tabs > .item').tab
#    onVisible: () ->
#      setCookie('last_active_tab', $(this).data('tab'), 365)
#    history: true
#    historyType: 'hash'
#
#  $('.menu.group-form-tabs > .item').tab
#    onVisible: () ->
#      setCookie('last_active_group_tab', $(this).data('tab'), 365)
#  $(document).on('click', '.nested-add-link',(e) ->
#    initComponents()
#  )
#
#  $('.nested-container').on('cocoon:after-remove', (event, element)->
#    checkAllButtons()
#  )
#
#  # https://github.com/Semantic-Org/Semantic-UI/issues/2072/#issuecomment-323809270
#  $('.select.allow-blank').dropdown fullTextSearch: 'exact', onChange: (value) ->
#    target = $(this).closest('.ui.dropdown')
#    if value != ''
#      target.find('.dropdown.icon').removeClass('dropdown').addClass('delete').on 'click', (e) ->
#        target.dropdown 'clear'
#        $(this).removeClass('delete').addClass('dropdown')
#        e.stopPropagation()
#    return
#
# #  force onChange event to fire on initialization
#  $('.select.allow-blank').closest('.ui.dropdown').find('.item.active').addClass('qwerty')
#    .end().dropdown('clear').find('.qwerty').removeClass('qwerty').trigger 'click'
#
#  $('.nested-container').on 'cocoon:after-insert', (event, element)->
#    checkPasteButtons()
#
#  $('.collapse-control').click ->
#    console.log('toggle')
#    $(this).find('.icon').toggleClass('slash') # use .eye.icon
#    $('.is-collapsible').toggle()
#
#  $('.collapse-block-fields-control').click ->
#    console.log('toggle-fieds')
#    $(this).find('.icon').toggleClass('open')
#    not_hidden_fields = $('.collapsible-block-field:not(.hidden)')
#    hidden_fields = $('.collapsible-block-field.hidden')
#    if not_hidden_fields.length
#      hideFields(not_hidden_fields)
#    else
#      showFields(hidden_fields)
#
#  $('.collapse-block-item-fields-control').click ->
#    console.log('toggle-items')
#    $(this).find('.icon').toggleClass('open')
#    not_hidden_fields = $('.collapsible-block-item-field:not(.hidden)')
#    hidden_fields = $('.collapsible-block-item-field.hidden')
#    if not_hidden_fields.length
#      hideFieldItems(not_hidden_fields)
#    else
#      showFieldItems(hidden_fields)
