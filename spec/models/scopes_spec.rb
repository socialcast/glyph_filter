require 'spec_helper'

describe GlyphFilter::ActiveRecordModelExtension do
  before :all do
    (['@'] + ("A".."Z").to_a).each {|character| User.create! :name => "#{character}user"}
  end
  context "for User" do
    describe '#glyph_filter' do
      context 'glyph_filter name, A' do
        subject { User.glyph_filter(:name, 'A')}
        it { should have(1).users }
        its('first.name') { should == 'Auser' }
      end
      context 'glyph_filter name and empty string' do
        subject { User.glyph_filter(:name, '')}
        it { should have(27).users }
        its('first.name') { should == '@user' }
      end
      context 'glyph_filter name and nil' do
        subject { User.glyph_filter(:name, nil)}
        it { should have(27).users }
        its('first.name') { should == '@user' }
      end
      context 'glyph_filter name and left_over character' do
        subject { User.glyph_filter(:name, '?')}
        it { should have(1).users }
        its('first.name') { should == '@user' }
      end
    end
  end
end