function initSomeFormTabs(url) {
    initFormTabs(url, $(".edit_something"), $("#some_link"))
}

function initFormTabs(url, form, click_object) {
    let form_data
    let form_data_new
    $(document).ready(function(){
        form_data = JSON.stringify(getFormData(form))
    })
    click_object.click(function (e) {
        e.preventDefault()
        form_data_new = JSON.stringify(getFormData(form))
        if (form_data_new !== form_data) {
            if (confirm("Данные формы были изменены! Вы хотите отменить изменения?")) {
                window.location.href = url
            }
        }
        else {
            window.location.href = url
        }
    })
}
