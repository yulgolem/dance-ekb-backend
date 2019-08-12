function getFormData($form) {
    const unindexed_array = $form.serializeArray()
    let indexed_array = {}
    $.map(unindexed_array, function (n, i) {
        indexed_array[n['name']] = n['value']
    })
    return indexed_array
}
