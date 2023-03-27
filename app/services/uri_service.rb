class UriService
  def self.external_uri?(host:, port:, selector:)
    (host != ENV.fetch("GOPHER_HOST") ||
     port != ENV.fetch("GOPHER_PORT", "70") ||
     !selector.delete_prefix("/").start_with?(ENV.fetch("GOPHER_PATH", "")))
  end

  def self.external_path?(path:)
    _, selector = path.split("/", 2)
    return if selector.nil?

    !selector.start_with?(ENV.fetch("GOPHER_PATH", ""))
  end
end
