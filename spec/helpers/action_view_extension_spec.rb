require 'spec_helper'

describe 'GlyphFilter::ActionViewExtension' do
  describe '#glyph_filter' do
    before do
      @params = {:controller => 'users', :action => 'index'}
    end
    subject { helper.glyph_filter :params => @params }
    it { should be_a String }
    context 'params with page' do
      before do
        @params = @params.merge(:page => '1')
      end
      context 'default behaviour' do
        subject { helper.glyph_filter(:params => @params) }
        it { should_not match /page\=1/}
      end
      context 'override excluded_params' do
        subject { helper.glyph_filter(:params => @params, :excluded_params => [:nothing]) }
        it { should match /page\=1/}
      end
    end
    context ':param_name' do
      context 'default behaviour' do
        subject { helper.glyph_filter(:params => @params) }
        it { should match /glyph\=A/}
      end
      context 'override :param_name' do
        subject { helper.glyph_filter(:params => @params, :param_name => :nothing) }
        it { should match /nothing\=A/}
      end
    end
    context ':left_over' do
      context 'default behaviour' do
        subject { helper.glyph_filter(:params => @params) }
        it { should match /glyph\=\%3F/}
      end
      context 'override :left_over' do
        subject { helper.glyph_filter(:params => @params, :left_over => 'nothing') }
        it { should match /glyph\=nothing/}
      end
    end
    context ':glyphs' do
      context 'default behaviour' do
        subject { helper.glyph_filter(:params => @params) }
        ("A".."Z").to_a.each do |glyph|
          it { should match /glyph\=#{glyph}/}
        end
      end
      context 'override :glyphs' do
        subject { helper.glyph_filter(:params => @params, :glyphs => ['a']) }
        it { should match /glyph\=a/}
        ("A".."Z").to_a.each do |glyph|
          it { should_not match /glyph\=#{glyph}/}
        end
      end
    end
    context ':current_section' do
      context 'default behaviour' do
        subject { helper.glyph_filter(:params => @params) }
        it { should match /\<span\sclass\=\"all\scurrent\"\>\s*ALL\s*\<\/span\>/}
      end
      context 'override :current_section' do
        subject { helper.glyph_filter(:params => @params, :current_section => 'A') }
        it { should match /\<span\sclass\=\"glyph\scurrent\"\>\s*A\s*\<\/span\>/}
      end
    end
    
  end
end