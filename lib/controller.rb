require './lib/server'

class Controller

  puts "Sending response."
  response = "<pre>#{p.hello_world}\nVERB: #{p.verb}\nPATH: #{p.path}\nPROTOCOL: #{p.protocol}\nHOST: #{p.host}\nPORT: #{p.port}\nORIGIN: #{p.origin}\nACCEPT: #{p.accept}</pre>"
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
response = request.each { |k, v| puts k + ": " + v }
