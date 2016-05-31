require 'faraday'

def test_it_can_get_home_page

  conn = Faraday.new(:url => 'http://127.0.0.1') do |faraday|
    faraday.request  :url_encoded
    faraday.response :logger
    faraday.adapter  Faraday.default_adapter
  end
  response = con.get
  response.body

end
