require "uri/gopher"

class GopherGetterService
  def initialize(path:, query_string: "")
    @filetype, @selector = path.split("/", 2)
    @query_string = query_string
    @uri = uri_for(filetype:, selector:, query_string:)
    @path = path_for(filetype:, selector:, query_string:)
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

  attr_reader :uri, :path, :filetype, :selector, :query_string

  def uri_for(filetype:, selector:, query_string:)
    URI::Gopher.new("gopher", nil, ENV.fetch("GOPHER_HOST"), ENV.fetch("GOPHER_PORT", "70"), nil,
                    path_for(filetype:, selector:, query_string:), nil, nil, nil)
  end

  def path_for(filetype:, selector:, query_string:)
    query_string = "%09#{query_string}" if query_string.present?
    "/#{filetype}/#{selector}#{query_string}"
  end
end
