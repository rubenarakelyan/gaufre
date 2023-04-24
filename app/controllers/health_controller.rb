class HealthController < ApplicationController
  rescue_from(Exception) { render_down }

  def show
    render_up
  end

  private

  def render_up
    render "up", layout: false
  end

  def render_down
    render "down", layout: false, status: :internal_server_error
  end
end
