class PagesController < ApplicationController
  def external_gopher_link
    @external_gopher_uri = params[:uri]
  end
end
