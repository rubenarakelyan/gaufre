class GopherMapEntryDecorator < ApplicationDecorator
  delegate_all

  def icon
    return nil if filetype == "i" # info entry

    case filetype
    when "0"
      "text.png"
    when "1"
      "dir.png"
    when "4"
      "binhex.png"
    when "5"
      "compressed.png"
    when "6"
      "uuencoded.png"
    when "9"
      "binary.png"
    when ":", "I", "g", "p"
      "image2.png"
    when ";"
      "movie.png"
    when "<", "s"
      "sound2.png"
    when "P"
      "pdf.png"
    when "h"
      "link.png"
    when "d"
      "generic.png"
    else
      "unknown.png"
    end
  end
end
