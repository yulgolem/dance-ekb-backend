$ ->
  $('form').on 'click', '.image_preview img', ->
    $(this).next().click();
    false
  $('form').on 'change', '.image_preview input[type="file"]', ->
    $image = $(this).prev()
    oFReader = new FileReader
    - if this.files[0]
      oFReader.readAsDataURL this.files[0]
      oFReader.onload = (oFREvent) ->
        $image.attr 'src', oFREvent.target.result
  $newImageNode = null
  $('.nested-container').on 'cocoon:after-insert', (event, element)->
    $newImageNode = $(element)
