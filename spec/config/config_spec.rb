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

require 'spec_helper'

describe GlyphFilter::Configuration do
  let(:glyph_filter_config) { GlyphFilter.config }
  describe 'glyphs' do
    subject { glyph_filter_config.glyphs }
    context 'by default' do
      it { is_expected.to eq(("A".."Z").to_a) }
    end
    context 'configured via config block' do
      before do
        GlyphFilter.configure {|c| c.glyphs = [1,2,3]}
      end
      it { is_expected.to eq([1,2,3]) }
      after do
        GlyphFilter.configure {|c| c.glyphs = ("A".."Z").to_a}
      end
    end
  end
  describe 'param_name' do
    subject { glyph_filter_config.param_name }
    it { is_expected.to eq(:glyph) }
  end

  describe 'left_over' do
    subject { glyph_filter_config.left_over }
    it { is_expected.to eq("?") }
  end
end
