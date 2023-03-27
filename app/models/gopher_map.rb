class GopherMap
  def initialize(rows:)
    @rows = rows
  end

  def to_a
    rows.map do |line|
      filetype = line.slice!(0)
      line = line.split("\t")
      GopherMapEntry.new(filetype:, name: line[0], selector: line[1], host: line[2], port: line[3])
    end.compact
  end

  private

  attr_reader :rows
end
