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

require File.join(File.dirname(__FILE__), 'filter_section')

module GlyphFilter
  module ActionViewExtension
    extend ::ActiveSupport::Concern
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
