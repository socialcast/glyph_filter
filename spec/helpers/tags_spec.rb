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

require 'spec_helper'

describe 'GlyphFilter::Helpers' do
  describe 'Tag' do
    describe '#initialize' do
      context 'no options' do
        before do
          stub(@template = Object.new) do
            params { {:controller => "users", :action => 'index'} }
          end
        end
        subject { GlyphFilter::Helpers::Tag.new(@template).instance_variable_get('@params') }
        it { should == {:controller => "users", :action => 'index'} }
      end
      context 'excluded_params of [page]' do
        before do
          stub(@template = Object.new) do
            params { {:controller => "users", :action => 'index', :page => '1'} }
          end
        end
        subject { GlyphFilter::Helpers::Tag.new(@template, :excluded_params => [:page]).instance_variable_get('@params') }
        it { should == {:controller => "users", :action => 'index'} }
      end
      context 'excluded_params of page' do
        before do
          stub(@template = Object.new) do
            params { {:controller => "users", :action => 'index', :page => '1'} }
          end
        end
        subject { GlyphFilter::Helpers::Tag.new(@template, :excluded_params => :page).instance_variable_get('@params') }
        it { should == {:controller => "users", :action => 'index'} }
      end
      context 'params of page' do
        before do
          stub(@template = Object.new) do
            params { {:controller => "users", :action => 'index'} }
          end
        end
        subject { GlyphFilter::Helpers::Tag.new(@template, :params => {:page => '1'}).instance_variable_get('@params') }
        it { should == {:controller => "users", :action => 'index', :page => '1'} }
      end
      context 'params of page and excluded_params of page' do
        before do
          stub(@template = Object.new) do
            params { {:controller => "users", :action => 'index'} }
          end
        end
        subject { GlyphFilter::Helpers::Tag.new(@template, :params => {:page => '1'}, :excluded_params => :page).instance_variable_get('@params') }
        it { should == {:controller => "users", :action => 'index'} }
      end
    end
  end
  describe 'Glyph' do
    describe '#section_value' do
      before do
        stub(@template = Object.new) do
          params { {:controller => "users", :action => 'index'} }
        end
      end
      subject { GlyphFilter::Helpers::Glyph.new(@template, :glyph => 'A') }
      its(:section_value) { should == 'A' }
    end
    describe '#url' do
      subject { GlyphFilter::Helpers::Glyph.new(helper, :params => {"controller" => 'users', "action" => 'index'}, :glyph => 'A', :param_name => :glyph) }
      its(:url) { should == "/users?glyph=A"}
    end
  end
  describe 'All' do
    describe '#url' do
      subject { GlyphFilter::Helpers::All.new(helper, :params => {"controller" => 'users', "action" => 'index', "glyph" => 'A'}, :param_name => :glyph) }
      its(:url) { should == "/users"}
    end
  end
end
