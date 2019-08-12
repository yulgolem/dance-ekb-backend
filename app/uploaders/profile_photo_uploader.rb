class ProfilePhotoUploader < BaseUploader
  process_standard_images w: 288 * 2, h: 312 * 2
end
