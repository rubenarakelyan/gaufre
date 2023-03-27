class GopherMapEntry
  attr_reader :filetype, :name, :selector, :host, :port

  def initialize(filetype:, name:, selector:, host:, port:)
    @filetype = filetype
    @name = name
    @selector = selector
    @host = host
    @port = port
  end

  def info?
    filetype == "i"
  end

  def external_html_link?
    filetype == "h"
  end

  def external_gopher_link?
    file? && UriService.external_uri?(host:, port:, selector:)
  end

  def file?
    %w[0 1 4 5 6 9 : ; < I M P d g p s].include?(filetype)
  end

  def link
    return "" if info?

    if external_html_link?
      selector.delete_prefix("URL:")
    elsif external_gopher_link?
      "/_/external_gopher_link?uri=#{host}:#{port}/#{filetype}#{selector}"
    else
      "/#{filetype}#{selector}"
    end
  end
end
