require "net/gopher"

class GopherGetterService
  def initialize(path:)
    @filetype, @selector = path.split("/", 2)
    @uri = uri_for(filetype:, selector:)
    @path = path_for(filetype:, selector:)
  end

  def call
    response = Net::Gopher.get(uri)

    {
      uri:,
      path:,
      filetype:,
      selector:,
      gopher_resource: GopherResource.new(filetype:, selector:, response:)
    }
  end

  def self.call(...)
    new(...).call
  end

  private

  attr_reader :uri, :path, :filetype, :selector

  def uri_for(filetype:, selector:)
    URI("gopher://#{ENV.fetch('GOPHER_HOST')}:#{ENV.fetch('GOPHER_PORT', 70)}#{path_for(filetype:, selector:)}")
  end

  def path_for(filetype:, selector:)
    "/#{filetype}/#{selector}"
  end
end
