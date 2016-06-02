require 'pry'

class RequestParser
  attr_reader :request

  def self.parse_requests(client)
    request_lines = []
    request = {}
    index = 0
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
      if index == 0
        #add to hash here
        (request['Verb'], request['Path'], request['Protocol']) =line.chomp.split
      else
        (key, value) = line.chomp.split(": ")
        request[key.strip] = value.strip
      end
      index += 1
    end
    request
  end

end
