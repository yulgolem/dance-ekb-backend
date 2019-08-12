$ ->
  # inline attachment - https://github.com/sparksuite/simplemde-markdown-editor/issues/328
  inlineAttachmentConfig =
    uploadUrl: '/admin/markdown_images'
    extraHeaders:
      'X-CSRF-Token': $.rails.csrfToken()
    extraParams:
      uploaded_from: window.location.href

  toggleBlock = (editor, type, start_chars, end_chars, placeholderText = '') ->
    if /editor-preview-active/.test(editor.codemirror.getWrapperElement().lastChild.className)
      return
    end_chars = if typeof end_chars == 'undefined' then start_chars else end_chars
    cm = editor.codemirror
    start = start_chars
    end = end_chars
    startPoint = cm.getCursor('start')
    endPoint = jQuery.extend({}, cm.getCursor('end'))
    text = cm.getSelection() || placeholderText
    cm.replaceSelection start + text + end
    startPoint.ch += start_chars.length
    endPoint.ch = startPoint.ch + text.length

    cm.setSelection startPoint, endPoint
    cm.focus()

  drawCaption = (editor) ->
    toggleBlock(editor, 'caption', '<div class="caption">', '</div>', 'Insert caption here');

  drawEmbed = (editor) ->
    toggleBlock(editor, 'caption', '<div class="iframe">', '</div>', 'Insert embed iframe code here');

  chooseImage = (editor) ->
    input = $(document.createElement("input"))
    input.attr("type", "file")
    input.attr("multiple", "multiple")
    options = inlineAttachmentConfig
    inlineAttachEditor = new inlineAttachment.editors.codemirrorBase(editor.codemirror)
    inlineattach = new inlineAttachment(options, inlineAttachEditor)

    input.change ->
      inlineattach.onFileSelect(this.files);

    input.click()

  chooseQuote = (editor) ->
    input = $(document.createElement("input"))
    input.attr("type", "file")
    options = inlineAttachmentConfig
    inlineAttachEditor = new inlineAttachment.editors.codemirrorBase(editor.codemirror)
    inlineattach = new inlineAttachment(options, inlineAttachEditor)

    input.change ->
      inlineattach.onFileSelectForQuote(this.files);

    input.click()

  $('textarea.markdown').each (_, element) ->
    simplemde = new SimpleMDE(
      element: element,
      toolbar: [
        "bold", "italic", "heading-2", "|", "quote", "|", "link",
        {
          name: "image",
          action: chooseImage,
          className: "fa fa-picture-o",
          title: "Insert Image"
        },
        {
          name: "quote",
          action: chooseQuote,
          className: "fa fa-share-square",
          title: "Insert Quote"
        },
        {
       		name: "caption",
       		action: drawCaption,
       		className: "fa fa-align-justify",
       		title: "Image caption"
       	},
        {
       		name: "embed",
       		action: drawEmbed,
       		className: "fa fa-video-camera",
       		title: "Embed"
       	},
        "|", "preview", "side-by-side", "fullscreen", "|", "guide"
      ]
      spellChecker: false
      previewRender: (plainText) ->
        '<div class="text">' + simplemde.markdown(plainText) + '</div>'
    )
    inlineAttachment.editors.codemirror4.attach simplemde.codemirror, inlineAttachmentConfig
    simplemde.codemirror.on "change", ->
      $('#text_html').val(simplemde.markdown(simplemde.value()))
