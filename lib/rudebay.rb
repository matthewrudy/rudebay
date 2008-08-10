require 'yaml'

%w( watcher twitterer describer ).each do |klass|
  require File.dirname(__FILE__) + "/rudebay/#{klass}"
end

module Rudebay
  class << self
    def prepare_config
      twitter_yml = File.dirname(__FILE__) + "/../config/twitter.yml"
      rtn = {}
      rtn[:twitter] = YAML.load(File.open(twitter_yml).read)
      return rtn
    end
    
    def config
      @config ||= prepare_config
    end
  end
end