module Rudebay
  class Describer
    TEMPLATES = [
      ":time_left out and it's at :current_price",  # "1 hour out and it's at £102"
      ":current_price, and only :time_left to go!", # "141 quid, and only 30 seconds to go"
      "that :item_title is at :current_price",      # that Peppa Pig pyjamas is at £12.23
    ]
    
    def self.get_a_template
      TEMPLATES[rand(TEMPLATES.length)].dup
    end
    
    def self.describe!(item_title, current_price, time_left)
      message = get_a_template
      message.sub!(':time_left',     "#{time_left}".strip)
      message.sub!(':current_price', "#{current_price}".strip)
      message.sub!(':item_title',    "#{item_title}".strip)
      
      return message
    end
  end
end