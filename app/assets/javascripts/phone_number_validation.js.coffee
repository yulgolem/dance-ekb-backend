# libphonenumber-js required
@initPhoneFormatting = () ->
  formatter = new libphonenumber.AsYouType()
  phoneParser = libphonenumber.parseNumber
  formatPhone = (input) ->
    formatter.reset()
    phone_num = formatter.input(input.val())
    if (phone_num.length != 0) && (phone_num[0] != '+')
      phone_num = '+' + phone_num
    $('form').form('set value', input.attr('name'), phone_num)

  validatePhone = (el) ->
    if jQuery.isEmptyObject(el.val())
      el.removeClass('field-error')
    else if jQuery.isEmptyObject(phoneParser(el.val()))
      el.addClass('field-error')
    else
      el.removeClass('field-error')

  $('.formatted-phone').each ->
    formatter.reset()
    phone_num = formatter.input($(this).val())
    if (phone_num[0] == '+') && (phone_num.length > 1)
      validatePhone $(this)

  $('.formatted-phone').on 'focus input', ->
    formatPhone $(this)
    $(this).removeClass('field-error')

  $('.formatted-phone').on 'change', ->
    validatePhone $(this)
