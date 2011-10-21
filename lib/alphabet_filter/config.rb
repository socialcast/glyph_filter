require 'active_support/configurable'

module AlphabetFilter

  def self.configure(&block)
    yield @config ||= AlphabetFilter::Configuration.new
  end

  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable
    config_accessor :letters
    config_accessor :param_name
    config_accessor :punctuation
    config_accessor :all
    
  end

  configure do |config|
    config.letters = ("A".."Z").to_a
    config.param_name = :letter
    config.punctuation = "?"
    config.all = "ALL"
  end
end