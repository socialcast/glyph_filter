require File.join(File.dirname(__FILE__), "..", 'test_helper')

class ConfigTest < ActiveSupport::TestCase
  test 'configure block yields GlyphFilter::Configuration instance' do
    GlyphFilter.configure do |config|
      assert_equal GlyphFilter::Configuration, config.class
    end
  end
  test 'config method returns GlyphFilter::Configuration instance' do
    assert_equal GlyphFilter::Configuration, GlyphFilter.config.class
  end
  test 'config instance should only have :glyphs, :param_name, and :left_over as options' do
    assert_equal [:glyphs, :param_name, :left_over], GlyphFilter.config.config.keys
  end
  {:glyphs => ("A".."Z").to_a, :param_name => :glyph, :left_over => "?"}.each_pair do |name, config|
    test "GlyphFilter::Configuration should have #{name} config set to #{config} by default" do 
      assert_equal config, GlyphFilter.config.send(name)
    end
  end
end
