%w( watcher twitterer describer ).each do |klass|
  require File.dirname(__FILE__) + "/rudebay/#{klass}"
end