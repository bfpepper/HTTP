# increment all_count
# return response
# return diag for everything
#
#
# /hello just returns Hello world (count)
#
# /datetime returns date and Time
#
# /shutdown gives total count and shuts down server_loop
#
# /word_search returns is word is known or not
#
# server is outputting response and diag output
#
# Response
#   - header
#     - Diagnostic info
#       - parsed request info
#         - inside request hash
#       - output (length)
#   - output
#     - needs path
#     - hello world
#       - needs hello world method
#         - counter
#     - shutdown (...)
#     - word search
#       - dictionary
#       - word
#below is the remains of route method, make sure to change all calls to response
def response(request)
  @all_count += 1
  diag = "<pre>\n#{request.each { |k, v| puts k + ": " + v }}</pre>"
  output = "<html><head></head><body>#{content(request)}\n\n#{diag}</body></html>"
  headers = ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")

def content(request)
  ""                  if request['Path'] == "/"
  hello_world         if request['Path'] == "/hello"
  datetime            if request['Path'] == "/datetime"
  shutdown            if request['Path'] == "/shutdown"
  word_search(word)   if request['Path'].include? "/word_search"
end

    def hello_world
      @hello_world += 1
      "Hello, world! (#{@hello_world})"
    end

    def datetime
      "date: #{Time.now.strftime('%l:%m %p on %A, %B %e, %Y')}"
    end

    def shutdown
      "Total requests: #{@all_count}"
    end

    def word_search(word)
      word_included = File.read("/usr/share/dict/words").split("\n").include?(word)
      word_included ? "#{word} is a known word" : "#{word} is not a known word"
      end
    end

    #below should be responder class

    puts "Sending response."
    puts ["Wrote this response:", headers, output].join("\n")
