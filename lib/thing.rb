if @path == "/hello"
  puts "Hello, world (#{hw_count})"
  hw_count += 1
elsif @path == "/datetime"
  puts "strftime thing"
elsif @path == "/shutdown"
  puts "Total requests: #{all_count}"
  client.close
elsif @path == "/"
  puts (debug thing)
