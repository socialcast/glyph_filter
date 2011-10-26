module GlyphFilter
  module Helpers
    class Tag
      def initialize(template, options={})
        @template, @options = template, options.dup
        @params = @options[:params] ? template.params.merge(@options.delete(:params)).except(@options[:excluded_params]) : template.params.except(@options[:excluded_params])
      end
      def to_s(locals = {})
        @template.render :partial => "glyph_filter/#{self.class.name.demodulize.underscore}", :locals => @options.merge(locals)
      end
      def filter_section_url_for(filter_section)
        these_params = if filter_section == @options[:all]
          @params.except(@options[:param_name].to_s)
        else
          @params.merge(@options[:param_name] => filter_section)
        end
        @template.url_for these_params
      end
    end
    module Link
      def section_value()
        raise "Must implement section_value to return what this sections value is"
      end
      def url
        filter_section_url_for section_value
      end
      def to_s(locals = {}) #:nodoc:
        super locals.merge(:url => url)
      end
    end
    class All < Tag
      include Link
      
      def section_value
        @options[:all]
      end
    end
    class Glyph < Tag
      include Link
      
      def section_value
        @options[:glyph]
      end
      def to_s(locals = {})
        super locals.merge(:glyph => section_value)
      end
    end
  end
end