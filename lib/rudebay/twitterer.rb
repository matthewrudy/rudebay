require 'net/http'
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
    
    REPLY_TEMPLATES = [
      "Yo, :user_name, :message",
      ":message, :user_name",
      ":user_name, mate, :message",
    ]
    def reply_to!(to_user, message)
      template = REPLY_TEMPLATES[rand(REPLY_TEMPLATES.length)]
      reply = template.dup
      reply.sub!(':user_name', "@#{to_user}")
      reply.sub!(':message', message)
      
      self.twitter!(reply)
    end
  end
end
