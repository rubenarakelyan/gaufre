class PagesController < ApplicationController
  before_action :validate_uri

  def external_gopher_link
    @external_gopher_uri = params[:uri]
  end

  private

  def validate_uri
    raise ActionController::RoutingError, "Not Found" if params[:uri].blank?
  end
end
