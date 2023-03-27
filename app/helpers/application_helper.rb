module ApplicationHelper
  def version
    "1.0.0"
  end

  def title
    ENV.fetch("TITLE", "Gaufre")
  end
end
