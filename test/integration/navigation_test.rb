require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test 'users index has glyph filter in the template' do
    visit users_path
    
    assert_match /\<div\sclass\=\"pagination\_wrapper\"\>/, page.body
    assert_match /\<div\sclass\=\"pagination\"\>/, page.body
    assert_match /\<span\sclass\=\"all\scurrent\"\>\s*ALL\s*\<\/span\>/, page.body
    (("A".."Z").to_a + ["?"]).each do |glyph|
      assert_match /\<span\sclass\=\"glyph\"\>\s*\<a href\=\"\/users\?glyph\=#{URI.escape(glyph, "?")}\"\>\s*#{Regexp.escape(glyph)}\s*\<\/a\>\s*\<\/span\>/, page.body
    end
  end
  test 'users index with glyph param has glyph filter in the template with glyph as current' do
    visit users_path(:glyph => "A")
    
    assert_match /\<div\sclass\=\"pagination\_wrapper\"\>/, page.body
    assert_match /\<div\sclass\=\"pagination\"\>/, page.body
    assert_match /\<span\sclass\=\"all\"\>\s*\<a href\=\"\/users\"\>\s*ALL\s*\<\/a\>\s*\<\/span\>/, page.body
    assert_match /\<span\sclass\=\"glyph\scurrent\"\>\s*A\s*\<\/span\>/, page.body
    (("B".."Z").to_a + ["?"]).each do |glyph|
      assert_match /\<span\sclass\=\"glyph\"\>\s*\<a href\=\"\/users\?glyph\=#{URI.escape(glyph, "?")}\"\>\s*#{Regexp.escape(glyph)}\s*\<\/a\>\s*\<\/span\>/, page.body
    end
  end
end
