@initOfflineFormView = ->
  photo_image = document.getElementById('offline-form-photo-lightgallery')
  if photo_image
    lightGallery photo_image, { controls: false }

  diploma_images = document.getElementById('offline-form-diploma-lightgallery')
  if diploma_images
    lightGallery diploma_images

  passport_images = document.getElementById('offline-form-passport-lightgallery')
  if passport_images
    lightGallery passport_images

  international_passport_images = document.getElementById('offline-form-international-passport-lightgallery')
  if international_passport_images
    lightGallery international_passport_images
