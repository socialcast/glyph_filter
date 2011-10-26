require 'active_support/configurable'

module GlyphFilter

  def self.configure(&block)
    yield @config ||= GlyphFilter::Configuration.new
  end

  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable
    config_accessor :glyphs
    config_accessor :param_name
    config_accessor :left_over
    config_accessor :all
    
  end

  configure do |config|
    config.glyphs = ("A".."Z").to_a
    config.param_name = :glyph
    config.left_over = "?"
    config.all = "ALL"
  end
end