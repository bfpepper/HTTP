require './lib/server'
require './lib/parser'

class Controller

  puts "Sending response."
  response = "<pre>#{p.hello_world}\n#{p.verb}\n#{p.path}\n#{p.protocol}\n#{p.host}\n#{p.port}\n#{p.origin}\n#{p.accept}</pre>"
  output = "<html><head></head><body>#{response}</body></html>"
  headers = ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output

    puts ["Wrote this response:", headers, output].join("\n")
    puts "\nResponse complete, exiting."

end
