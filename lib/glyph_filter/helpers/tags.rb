=begin
Copyright (c) 2011-2012 VMware, Inc. All Rights Reserved.


Permission is hereby granted, free of charge, to any person obtaining a copy
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

module GlyphFilter::Helpers
  class Tag
    def initialize(template, options={})
      @template, @options = template, options.dup
      @params = @options[:params] ? template.params.merge(@options.delete(:params)).except(*@options[:excluded_params]) : template.params.except(*@options[:excluded_params])
    end
    def to_s(locals = {})
      @template.render :partial => "glyph_filter/#{self.class.name.demodulize.underscore}", :locals => @options.merge(locals)
    end
    def filter_section_url_for(filter_section)
      these_params = if self.is_a?(All)
        @params.except(@options[:param_name].to_s)
      else
        @params.merge(@options[:param_name] => filter_section)
      end
      these_params[:only_path] = true
      these_params.permit! if these_params.respond_to?(:permit!)

      @template.url_for these_params
    end
  end
  module Link
    def section_value()
      raise "Must implement section_value to return what this sections value is"
    end
    def url
      value = if self.is_a?(All)
        nil
      else
        section_value
      end
      filter_section_url_for value
    end
    def to_s(locals = {}) #:nodoc:
      super locals.merge(:url => url)
    end
  end
  class All < Tag
    include Link
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
