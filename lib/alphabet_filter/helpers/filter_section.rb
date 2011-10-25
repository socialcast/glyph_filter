require File.join(File.dirname(__FILE__), 'tags')
require 'action_view/context'

module AlphabetFilter
  module Helpers
    class FilterSection < Tag
      include ActionView::Context
      
      def initialize(template, options)
        @template, @options = template, options
        @options[:current_section] = SectionProxy.new @options, @options[:current_section]
        @output_buffer = ActionView::OutputBuffer.new
      end
      def render(&block)
        instance_eval &block
        @output_buffer
      end
      def to_s(locals = {})
        return super @options.merge :filter_section => self
      end
      
      def each_glyph
        (@options[:letters] + [@options[:left_over]]).each do |letter|
          yield SectionProxy.new @options, letter
        end
      end

      def glyph_tag(glyph)
        Glyph.new @template, @options.merge(:glyph => glyph)
      end
      
      def all_tag
        All.new @template, @options
      end
      
      class SectionProxy
        def initialize(options, section)
          @options, @section = options, section
        end
        def current?
          @section == @options[:current_section].to_s
        end
        def all?
          @section == @options[:all]
        end
        def left_over?
          @section == @options[:left_over]
        end
        def to_s
          @section.to_s
        end
      end
    end
  end
end