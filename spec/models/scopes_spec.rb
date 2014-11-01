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
    describe '#glyph_filter' do
      context 'glyph_filter name, A' do
        subject { User.glyph_filter(:name, 'A')}
        it 'has 1 user' do
          expect(subject.size).to eq(1)
        end

        describe '#first' do
          subject { super().first }
          describe '#name' do
            subject { super().name }
            it { is_expected.to eq('Auser') }
          end
        end
      end
      context 'glyph_filter name and empty string' do
        subject { User.glyph_filter(:name, '')}
        it 'has 27 users' do
          expect(subject.size).to eq(27)
        end

        describe '#first' do
          subject { super().first }
          describe '#name' do
            subject { super().name }
            it { is_expected.to eq('@user') }
          end
        end
      end
      context 'glyph_filter name and nil' do
        subject { User.glyph_filter(:name, nil)}
        it 'has 27 users' do
          expect(subject.size).to eq(27)
        end

        describe '#first' do
          subject { super().first }
          describe '#name' do
            subject { super().name }
            it { is_expected.to eq('@user') }
          end
        end
      end
      context 'glyph_filter name and left_over character' do
        subject { User.glyph_filter(:name, '?')}
        it 'has 1 user' do
          expect(subject.size).to eq(1)
        end

        describe '#first' do
          subject { super().first }
          describe '#name' do
            subject { super().name }
            it { is_expected.to eq('@user') }
          end
        end
      end
    end
  end
end
