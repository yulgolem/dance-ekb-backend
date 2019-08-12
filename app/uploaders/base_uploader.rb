class BaseUploader < Shrine
  # The determine_mime_type plugin allows you to determine and store the actual MIME type of the file analyzed from file content.
  plugin :determine_mime_type
  # The remove_attachment plugin allows you to delete attachments through checkboxes on the web form.
  plugin :remove_attachment
  # The store_dimensions plugin extracts and stores dimensions of the uploaded image using the fastimage gem, which has built-in protection against image bombs.
  plugin :store_dimensions
  # The pretty_location plugin attempts to generate a nicer folder structure for uploaded files.
  plugin :pretty_location, namespace: "/"
  # Allows you to define processing performed for a specific action.
  plugin :processing
  # The versions plugin enables your uploader to deal with versions, by allowing you to return a Hash of files when processing.
  plugin :versions
  # The delete_promoted plugin deletes files that have been promoted, after the record is saved. This means that cached files handled by the attacher will automatically get deleted once they're uploaded to store. This also applies to any other uploaded file passed to Attacher#promote.
  plugin :delete_promoted
  # The delete_raw plugin will automatically delete raw files that have been uploaded. This is especially useful when doing processing, to ensure that temporary files have been deleted after upload.
  plugin :delete_raw
  # The cached_attachment_data plugin adds the ability to retain the cached file across form redisplays, which means the file doesn't have to be reuploaded in case of validation errors.
  plugin :cached_attachment_data
  # The upload_endpoint plugin provides a Rack endpoint which accepts file uploads and forwards them to specified storage
  plugin :upload_endpoint
  # Always keep uploaded files, as copying some models via admin ui
  # copies only references, not the files themselves,
  # also it's aligned with soft deleting
  plugin :keep_files, replaced: true, destroyed: true

  def generate_location(io, context)
    (context[:record].instance_variable_get(:'@old_filenames') || {})[context[:version]] || "uploads/#{super}"
  end

  def self.process_standard_images(w:, h: nil)
    process(:store) do |io, _context|
      original = io.download

      main = ImageProcessing::Vips
        .source(original)
        .convert("jpg")
        .saver(quality: 80, strip: true, lossless: true)
        .call

      thumbnail = ImageProcessing::Vips
        .source(main)
        .resize_to_limit(w, h)
        .call

      original.close!

      {
        original: io,
        main: main,
        thumbnail: thumbnail,
      }
    rescue => e
      ErrorTracker.new(
        message: "Error occurred while processing standard image",
        exception: e, silent: true
      )
      # TODO: should return error to client, as now uploading spinner and blank zone will occur after error without any message
      io.delete # abort processing and clear storage
      nil
    end
  end

  # converting should not be applied for icons, as we couldn't guess what alpha channel used if one presents

  def self.upload_file
    process(:store) do |io, _context|
      versions = {original: io}

      # if determine_mime_type(original) == "application/pdf"
      if mime_type_analyzers[:file].call(io) == "application/pdf"
        original = io.download
        preview = Tempfile.new(%w[shrine-pdf-preview .pdf], binmode: true)
        begin
          IO.popen %W[mutool draw -F png -o - #{original.path} 1], "rb" do |command|
            IO.copy_stream(command, preview)
          end
          preview.open # flush & rewind
        rescue SystemCallError => e
          ErrorTracker.new(
            message: "Error while processing PDF file: probably mutool is not installed",
            exception: e, silent: true
          )
          preview.delete
          # TODO: use some stub instead generated preview
        end
        versions[:preview] = preview if (preview&.size || 0) > 0
      end

      versions
    rescue => e
      ErrorTracker.new(
        message: "Error occurred while file uploading",
        exception: e, silent: true
      )
      io.delete
      nil
    end
  end
end

# shrine file hash example
# {
#   "id": "349234854924394", # required, location of the file on S3 (minus the :prefix)
#   "storage": "cache", # required, direct uploads typically use the :cache storage
#   "metadata": { hash of metadata extracted from the file
#     "size": 45461, # optional, but recommended
#     "filename": "foo.jpg", # optional
#     "mime_type": "image/jpeg" # optional
#   }
# }
