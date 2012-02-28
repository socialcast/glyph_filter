require 'spec_helper'

describe GlyphFilter::Configuration do
  subject { GlyphFilter.config }
  describe 'glyphs' do
    context 'by default' do
      its(:glyphs) { should == (("A".."Z").to_a) }
    end
    context 'configured via config block' do
      before do
        GlyphFilter.configure {|c| c.glyphs = [1,2,3]}
      end
      its(:glyphs) { should == [1,2,3] }
      after do
        GlyphFilter.configure {|c| c.glyphs = ("A".."Z").to_a}
      end
    end
  end
  describe 'param_name' do
    context 'by default' do
      its(:param_name) { should == :glyph }
    end
  end

  describe 'left_over' do
    context 'by default' do
      its(:left_over) { should == "?" }
    end
  end
end