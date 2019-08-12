$(document).ready(function() {
    checkPasteButtons()

    $('.copy-form').click(function (e) {
        e.preventDefault()
        deselectize()
        const dataObj = $(this).closest('.nested-fields')[0].outerHTML
        const klass = $(this).closest('.nested-container').attr('id')
        localStorage.dataObj = JSON.stringify(dataObj)
        localStorage.stored_form_klass = klass
        checkPasteButtons()
        initComponents()
      new Noty({
        theme: 'semanticui',
        text: 'Скопировано!',
        timeout: 500,
        progressBar: false
      }).show()
    })

    $('.paste-form').click(function (e) {
        e.preventDefault()
        const dataObj = JSON.parse(localStorage.getItem('dataObj'))
        let form_container = $(this).parent().parent().find('.form-container')
        $(form_container).append(dataObj)
        let pasted_object = form_container.find('> .nested-fields').last()
        postprocessPastedData(pasted_object)
    })
})

function postprocessPastedData(object) {
    object.find('input[id$=id]').remove() // Удаляем скрытые ID-поля
    let dictionary = {}
    const fields = object.find('[name]')
    jQuery.each(fields, function(index, field) {
        // numbers = field.name.match(/\[(\d)\]/g)
        const numbers = field.name.match(/\[[0-9]\]+(?!.*[0-9]\S\w*\S)/g)
        jQuery.each(numbers, function(i, number) {
            const dictionary_number = number.replace(/\[/, "").replace(/\]/, "")
            if (dictionary[dictionary_number] == null) {
                dictionary[dictionary_number] = new Date().getTime() + i
            }
            if (field.name.match(/\[[0-9]\]+(?!.*[0-9]\S\w*\S)/g) === number)
            {
                field.name = field.name.replace(/\[[0-9]\]+(?!.*[0-9]\S\w*\S)/g, '[' + dictionary[dictionary_number] + "]")
                field.id = field.id.replace('_' + dictionary_number + '_', '_' + dictionary[dictionary_number] + "_")
            }
        })
    })

    const placeholder_src = $(document).find('img[data-placeholder]').attr('data-placeholder')
    let images = object.find('img')
    jQuery.each(images, function(index, image) {
        image.src = placeholder_src
    })

    initComponents()
}

function checkPasteButtons() {
    $('.paste-form').hide()
    const klass = localStorage.stored_form_klass
    if (klass != null) {
        $('.paste-form.' + klass).show()
    }
}

function deselectize() {
    $('select').each(function(){
        if ($(this)[0].selectize) {
            let value = $(this).val()
            $(this)[0].selectize.destroy()
            $(this).val(value)
        }
    })
}
