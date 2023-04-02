module Net
  # == A Gopher client API for Ruby.
  #
  # Net::Gopher provides a library which can be used to build Gopher
  # user-agents.
  #
  # Net::Gopher is designed to work closely with URI.
  #
  # == Simple Examples
  #
  # All examples assume you have loaded Net::Gopher with:
  #
  #   require 'net/gopher'
  #
  # This will also require 'uri' so you don't need to require it
  # separately.
  #
  # The Net::Gopher methods in the following section do not persist
  # connections.
  #
  # === GET by URI
  #
  #   uri = URI('gopher://thelambdalab.xyz/1/projects/elpher/')
  #   Net::Gopher.get(uri) # => String
  #
  class Gopher
    def self.get(uri)
      sock = TCPSocket.new(uri.host, uri.port)
      sock.puts "#{uri.selector.gsub('%09', '	')}\r\n"
      sock.read
    ensure
      # Stop remaining connection, even if they should be already cut
      # by the server
      sock&.close
    end
  end
end
