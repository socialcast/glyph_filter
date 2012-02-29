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