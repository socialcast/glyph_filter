=begin
Copyright (c) 2011-2012 VMware, Inc. All Rights Reserved.

COPYING PERMISSION STATEMENT: In addition to the copyright notice, the
following copying permission statement should be added immediately following
the VMware copyright notice in the source.

“Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to
deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
=end

require File.join(File.dirname(__FILE__), 'tags')
require 'action_view/context'

module GlyphFilter
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
        (@options[:glyphs] + [@options[:left_over]]).each do |glyph|
          yield SectionProxy.new @options, glyph
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
          @section.nil?
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
