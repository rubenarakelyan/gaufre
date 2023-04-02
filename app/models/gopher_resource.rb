class GopherResource
  GOPHER_MAP_ENTRY_PATTERN = /^(\S)([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)/

  def initialize(filetype:, selector:, response:)
    @filetype = filetype
    @selector = selector
    @resource = response
  end

  def object
    if gopher_map?
      GopherMap.new(rows: to_a)
    elsif search?
      GopherSearch.new(selector:)
    else
      GopherFile.new(filetype:, selector:, resource:)
    end
  end

  def gopher_map?
    filetype == "1" && to_a[0].match?(GOPHER_MAP_ENTRY_PATTERN)
  end

  def search?
    filetype == "7"
  end

  def file?
    !gopher_map? && !search?
  end

  private

  attr_reader :filetype, :selector, :resource

  def to_a
    resource.split("\r\n").map { |s| s.split("\r") }.map { |s| s.split("\n") }.flatten
  end
end
