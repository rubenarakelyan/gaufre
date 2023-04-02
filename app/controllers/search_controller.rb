class SearchController < ApplicationController
  before_action :validate_uri

  def show
    return redirect_to "#{params[:uri]}?#{params[:q]}" if params[:q]

    @search_uri = params[:uri]
  end

  private

  def validate_uri
    raise ActionController::RoutingError, "Not Found" if params[:uri].blank?
  end
end
