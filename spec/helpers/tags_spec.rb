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

describe 'GlyphFilter::Helpers', :type => :helper do
  describe 'Tag' do
    describe '#initialize' do
      context 'no options' do
        before do
          @template = double(:params => { :controller => "users", :action => 'index' })
        end
        subject { GlyphFilter::Helpers::Tag.new(@template).instance_variable_get('@params') }
        it { is_expected.to eq({:controller => "users", :action => 'index'}) }
      end
      context 'excluded_params of [page]' do
        before do
          @template = double(:params => { :controller => "users", :action => 'index', :page => '1' })
        end
        subject { GlyphFilter::Helpers::Tag.new(@template, :excluded_params => [:page]).instance_variable_get('@params') }
        it { is_expected.to eq({:controller => "users", :action => 'index'}) }
      end
      context 'excluded_params of page' do
        before do
          @template = double(:params => { :controller => "users", :action => 'index', :page => '1' })
        end
        subject { GlyphFilter::Helpers::Tag.new(@template, :excluded_params => :page).instance_variable_get('@params') }
        it { is_expected.to eq({:controller => "users", :action => 'index'}) }
      end
      context 'params of page' do
        before do
          @template = double(:params => { :controller => "users", :action => 'index' })
        end
        subject { GlyphFilter::Helpers::Tag.new(@template, :params => {:page => '1'}).instance_variable_get('@params') }
        it { is_expected.to eq({:controller => "users", :action => 'index', :page => '1'}) }
      end
      context 'params of page and excluded_params of page' do
        before do
          @template = double(:params => { :controller => "users", :action => 'index' })
        end
        subject { GlyphFilter::Helpers::Tag.new(@template, :params => {:page => '1'}, :excluded_params => :page).instance_variable_get('@params') }
        it { is_expected.to eq({:controller => "users", :action => 'index'}) }
      end
    end
  end
  describe 'Glyph' do
    describe '#section_value' do
      before do
        @template = double(:params => { :controller => "users", :action => 'index' })
      end
      subject { GlyphFilter::Helpers::Glyph.new(@template, :glyph => 'A') }

      describe '#section_value' do
        subject { super().section_value }
        it { is_expected.to eq('A') }
      end
    end
    describe '#url' do
      subject { GlyphFilter::Helpers::Glyph.new(helper, :params => {"controller" => 'users', "action" => 'index'}, :glyph => 'A', :param_name => :glyph) }

      describe '#url' do
        subject { super().url }
        it { is_expected.to eq("/users?glyph=A")}
      end
    end
  end
  describe 'All' do
    describe '#url' do
      subject { GlyphFilter::Helpers::All.new(helper, :params => {"controller" => 'users', "action" => 'index', "glyph" => 'A'}, :param_name => :glyph) }

      describe '#url' do
        subject { super().url }
        it { is_expected.to eq("/users")}
      end
    end
  end
end
