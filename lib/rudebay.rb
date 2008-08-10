%w( watcher twitterer ).each do |klass|
  require File.dirname(__FILE__) + "/rudebay/#{klass}"
end