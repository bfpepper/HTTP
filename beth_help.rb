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

      def response(request)
        respond = "<pre>\n#{request.each { |k, v| puts k + ": " + v }}</pre>"
        output = "<html><head></head><body>#{content}\n\n#{respond}</body></html>"
        headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")

        @all_count += 1

        content = hello_world                     if request['Path'] == "/hello"
        content = datetime                        if request['Path'] == "/datetime"
        content = "Total requests: #{@all_count}" if request['Path'] == "/shutdown"
        content = ["Wrote this response:", headers, output].join("\n") if request['Path'] == "/"

        content = word_search(word)                if ,,,,

          # puts "Sending response."
          puts
        elsif request['Path'].include? "/word_search"
          word = request['Path'].partition('=').last

        end
        response = [headers + output]
      end

def datetime
  "date: #{Time.now.strftime('%l:%m %p on %A, %B %e, %Y')}"
end
