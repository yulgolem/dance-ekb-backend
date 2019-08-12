class ImageUploader < BaseUploader
  process_standard_images w: 300 * 2, h: 300 * 2
end
