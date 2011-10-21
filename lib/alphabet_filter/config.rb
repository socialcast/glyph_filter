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

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call() : config.param_name 
    end
  end

  # this is ugly. why can't we pass the default value to config_accessor...?
  configure do |config|
    config.default_per_page = 25
    config.window = 4
    config.outer_window = 0
    config.left = 0
    config.right = 0
    config.param_name = :page
  end
end