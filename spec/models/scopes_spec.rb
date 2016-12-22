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

describe GlyphFilter::ActiveRecordModelExtension, :type => :model do
  before :all do
    (['@'] + ("A".."Z").to_a).each {|character| User.create! :name => "#{character}user"}
  end
  context "for User" do
    describe '.glyph_filter' do
      let(:user_glyph_filter) { User.glyph_filter(*glyph_filter_args) }
      context 'glyph_filter name, A' do
        let(:glyph_filter_args) { [:name, 'A'] }
        it do
          expect(user_glyph_filter.size).to eq(1)
          expect(user_glyph_filter.first.name).to eq 'Auser'
        end
      end
      context 'glyph_filter name and empty string' do
        let(:glyph_filter_args) { [:name, ''] }
        it 'has 27 users' do
          expect(user_glyph_filter.size).to eq(27)
          expect(user_glyph_filter.first.name).to eq '@user'
        end
      end
      context 'glyph_filter name and nil' do
        let(:glyph_filter_args) { [:name, nil] }
        it 'has 27 users' do
          expect(user_glyph_filter.size).to eq(27)
          expect(user_glyph_filter.first.name).to eq '@user'
        end
      end
      context 'glyph_filter name and left_over character' do
        let(:glyph_filter_args) { [:name, '?'] }
        it 'has 1 user' do
          expect(user_glyph_filter.size).to eq(1)
          expect(user_glyph_filter.first.name).to eq '@user'
        end
      end
    end
  end
end
