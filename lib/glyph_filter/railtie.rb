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

require 'rails'

require 'glyph_filter/config'
require 'glyph_filter/helpers/action_view_extension'

module GlyphFilter
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'glyph_filter' do |app|
      ActiveSupport.on_load(:active_record) do
        require 'glyph_filter/models/active_record_extension'
        ::ActiveRecord::Base.send :include, GlyphFilter::ActiveRecordExtension
      end

      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, GlyphFilter::ActionViewExtension
      end
    end
  end
end
