require 'uri'
require 'net/http'
module Rudebay
  class Twitterer
    def initialize(user_hash)
      @username, @password = user_hash["username"], user_hash["password"]
    end
    
    def self.make_tinyurl(link)
      url = URI.parse('http://tinyurl.com/api-create.php')
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data('url' => link)
      res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }

      return res.body
    end
    
    def twitter!(status, link=nil)
      url = URI.parse('http://twitter.com/statuses/update.xml')
      req = Net::HTTP::Post.new(url.path)
      req.basic_auth @username, @password
      message = status.dup
      message = "#{message}, #{self.class.make_tinyurl(link)}" if link
      req.set_form_data('status' => message)
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
    def reply_to!(to_user, message, link=nil)
      template = REPLY_TEMPLATES[rand(REPLY_TEMPLATES.length)]
      reply = template.dup
      reply.sub!(':user_name', "@#{to_user}")
      reply.sub!(':message', message)
      
      self.twitter!(reply, link)
    end
  end
end
