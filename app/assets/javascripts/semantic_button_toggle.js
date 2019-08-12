semantic = {};
semantic.toggler = {};

semantic.toggler.init = function() {
    semantic.toggler.block()
    semantic.toggler.items()
    checkAllButtons()
}

// ready event
semantic.toggler.block = function(element) {
    // selector cache
    let $buttons = $(".ui.button.collapse-block-element-control"),
        handler = {
            activate: function() {
                $icon = $(this).find(".icon");
                $icon.hasClass("plus")
                    ? showBlock($(this))
                    : hideBlock($(this))
            }
        };

    $buttons.on("click", handler.activate);
};

semantic.toggler.items = function(element) {
    // selector cache
    let $buttons = $(".ui.button.collapse-block-element-item-control"),

        handler = {
            activate: function() {
                $icon = $(this).find(".icon");
                $icon.hasClass("plus")
                    ? showBlockItems($(this))
                    : hideBlockItems($(this))
            }
        };
    $buttons.on("click", handler.activate);
};

$(document).ready(
    semantic.toggler.init
);

hideBlock = function(element) {
    let collapsible = element.closest('.nested-fields.ui.segment').find('.collapsible-block-field')
    collapsible.hide()
    collapsible.addClass('hidden')
    hideButton(element)
}

hideBlockItems = function(element) {
    let collapsible_items = element.closest('.nested-fields.ui.segment').find('.collapsible-block-item-field')
    collapsible_items.hide()
    collapsible_items.addClass('hidden')
    hideButton(element)
}

showBlock = function(element) {
    let collapsible = element.closest('.nested-fields.ui.segment').find('.collapsible-block-field')
    collapsible.show()
    collapsible.removeClass('hidden')
    showButton(element)
}

showBlockItems = function(element) {
    let collapsible_items = element.closest('.nested-fields.ui.segment').find('.collapsible-block-item-field')
    collapsible_items.show()
    collapsible_items.removeClass('hidden')
    showButton(element)
}

hideButton = function(button) {
    button.html('<i class="plus icon"></i> Развернуть')
    checkContentCount(button)
}

showButton = function(button) {
    button.html('<i class="minus icon"></i> Свернуть')
    checkContentCount(button)
}

checkAllButtons = function() {
    let $buttons = $(".ui.button.collapse-block-element-control")
    $buttons.each(function(index){
        $icon = $(this).find('.icon:first-child')
        $icon.hasClass("plus")
            ? hideButton($(this))
            : showButton($(this))
    })

}

checkContentCount = function(button) {
    let count = button.closest('.nested-fields.ui.segment').find('.nested-container').find('> .nested-fields.ui.segment').length
    if (count) {
        let html = '<i class = "sitemap icon" style="margin-left:5px;"></i>' + count
        button.append(html)
    }
}
