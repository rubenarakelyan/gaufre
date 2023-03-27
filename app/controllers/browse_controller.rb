class BrowseController < ApplicationController
  before_action :warn_on_external_uri

  def show
    response = GopherGetterService.call(path: params[:gopher_path])
    gopher_resource = response[:gopher_resource]
    obj = gopher_resource.object
    @uri = response[:uri]

    if gopher_resource.gopher_map?
      render "show_gopher_map", locals: { gopher_map: GopherMapEntryDecorator.decorate_collection(obj.to_a).decorated_collection }
    elsif obj.text?
      render "show_text", formats: :html, locals: { content: obj.content }
    elsif obj.image? && ENV.fetch("INLINE_IMAGES", "false") == "true"
      render "show_image", formats: :html, locals: { content: obj.content, mime_type: obj.mime_type }
    else
      send_data(obj.content, filename: obj.filename, type: obj.mime_type)
    end
  end

  private

  def warn_on_external_uri
    external_path = UriService.external_path?(path: params[:gopher_path])

    if external_path.nil?
      raise ActionController::RoutingError.new("Not Found") if external_path.nil?
    elsif external_path
      redirect_to "/_/external_gopher_link?uri=#{ENV.fetch('GOPHER_HOST')}:#{ENV.fetch('GOPHER_PORT', '70')}/#{params[:gopher_path]}"
    end
  end
end
