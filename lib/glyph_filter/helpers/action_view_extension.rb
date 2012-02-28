require File.join(File.dirname(__FILE__), 'filter_section')

module GlyphFilter
  module ActionViewExtension
    extend ::ActiveSupport::Concern
    module InstanceMethods
      def glyph_filter(options = {}, &block)
        options.reverse_merge!(
          :param_name => GlyphFilter.config.param_name, 
          :left_over => GlyphFilter.config.left_over, 
          :excluded_params => [:page], 
          :glyphs => GlyphFilter.config.glyphs, 
          :current_section => (params[GlyphFilter.config.param_name] ? params[GlyphFilter.config.param_name] : nil)
        )
        filter_section = GlyphFilter::Helpers::FilterSection.new(self, options)
        filter_section.to_s
      end
    end
  end
end