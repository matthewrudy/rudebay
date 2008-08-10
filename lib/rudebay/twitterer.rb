module Rudebay
  class Twitterer
    def initialize(username, password)
      @username, @password = username, password
    end
    
    def twitter!(status)
      url = URI.parse('http://twitter.com/statuses/update.xml')
      req = Net::HTTP::Post.new(url.path)
      req.basic_auth @username, @password
      req.set_form_data('status' => status)
      res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
      case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        # OK
      else
        res.error!
      end
    end
  end
end
