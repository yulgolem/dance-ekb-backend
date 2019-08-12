$ ->
  $('.sidebar__menu').hover ((e) ->
    $('.sidebar').addClass 'active'
  ), (e) ->
    $('.sidebar').removeClass 'active'

  $('#MenuToggle').click ((e) ->
    $('.sidebar').toggleClass 'active'
  )
