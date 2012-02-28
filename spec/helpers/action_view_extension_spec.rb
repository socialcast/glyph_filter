require 'spec_helper'

describe 'GlyphFilter::ActionViewExtension' do
  describe '#glyph_filter' do
    
    subject { helper.glyph_filter :params => {:controller => 'users', :action => 'index'} }
    it { should be_a String }
  end
end