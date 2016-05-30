require 'pry'
# require './lib/server'

class Parser
  attr_reader :request_lines,
              :verb,
              :path,
              :protocol,
              :host,
              :port,
              :origin,
              :accept

  def initialize(request_lines)
    # binding.pry
    @verb = "VERB: #{request_lines[0].split[0]}"
    @path = "PATH: #{request_lines[0].split[1]}"
    @protocol = "PROTOCOL: #{request_lines[0].split[2]}"
    @host = "HOST: #{request_lines[1].split[1].split(':')[0]}"
    @port = "PORT: #{request_lines[1].split[1].split(':')[1]}"
    @origin = "ORIGIN: #{request_lines[1].split[1]}"
    @accept = "ACCEPT: #{request_lines[6].split[1]}"
  end

  # def hello_world
  #   "Hello, world! (#{hw_count})"
  # end
  #
  # def verb
  #   "VERB: #{request_lines[0].split[0]}"
  # end
  #
  # def path
  #   "PATH: #{request_lines[0].split[1]}"
  # end
  #
  # def protocol
  #   "PROTOCOL: #{request_lines[0].split[2]}"
  # end
  #
  # def host
  #   "HOST: #{request_lines[1].split[1].split(':')[0]}"
  # end
  #
  # def port
  #   "PORT: #{request_lines[1].split[1].split(':')[1]}"
  # end
  #
  # def origin
  #   "ORIGIN: #{request_lines[1].split[1]}"
  # end
  #
  # def accept
  #   "ACCEPT: #{request_lines[6].split[1]}"
  # end

end
