class GopherFile
  attr_reader :filename, :mime_type

  def initialize(filetype:, selector:, resource:)
    @filetype = filetype
    @filename = filename_for(selector:)
    @mime_type = mime_type_for(filetype:, content: resource)
    @resource = resource
  end

  def content
    if image? && ENV.fetch("INLINE_IMAGES", "false") == "true"
      Base64.encode64(resource)
    else
      resource
    end
  end

  def text?
    mime_type == "text/plain"
  end

  def image?
    mime_type.split("/")[0] == "image"
  end

  private

  attr_reader :filetype, :resource

  def filename_for(selector:)
    selector.split("/").last
  end

  def mime_type_for(filetype:, content:)
    case filetype
    when "0"
      "text/plain"
    when "P"
      "application/pdf"
    when "g"
      "image/gif"
    when "h"
      "text/html"
    when "p"
      "image/png"
    when "4", "5", "6", "9", ":", ";", "<", "I", "M", "d", "s"
      # Use marcel to figure out what we have
      Marcel::MimeType.for(StringIO.new(content))
    else
      # Something unexpected
      "application/octet-stream"
    end
  end
end
