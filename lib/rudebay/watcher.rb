require 'rubygems'
require 'open-uri'
require 'hpricot'
module Rudebay
  # we use hpricot to screenscrape,
  # because the Ebay API setup doesnt work in Firefox 3.
  #
  # (they should sort that out)
  class Watcher
    def initialize(item_id)
      @item_id = item_id
      data = self.class.fetch_page(item_id)
      @hpricot = Hpricot(data)
    end
    attr_reader :item_id, :hpricot
    
    def self.view_item_url(item_id)
      "http://cgi.ebay.co.uk/ws/eBayISAPI.dll?ViewItem&item=#{item_id}"
    end
    
    def self.fetch_page(item_id)
      url = view_item_url(item_id)
      data = open(url).read
    end
    
    def item_title
      (@hpricot/"#itemTitle").inner_text # Garlando G500 Football Table
    end
    
    def current_price
      (@hpricot/"#DetailsCurrentBidValue b").inner_text # £150.00
    end
    
    def time_left
      (@hpricot/"#DetailsTimeLeft b").inner_text # 20 hours 16 mins
    end
  end
end
