require File.join(File.dirname(__FILE__), "..", 'test_helper')

class ActiveRecordModelExtensionTest < ActiveSupport::TestCase
  test "glyph_filter should return an ActiveRecord::Relation" do
    assert_equal ActiveRecord::Relation, User.glyph_filter(:name, nil).class
  end
  test "glyph passed is nil should not add any conditions" do
    assert_equal User.where({}).to_sql, User.glyph_filter(:name, nil).to_sql
  end
  test "glyph passed is an empty string should not add any conditions" do
    assert_equal User.where({}).to_sql, User.glyph_filter(:name, '').to_sql
  end
  test "glyph passed is equal to left_over config should search for everything that is not the glyphs config" do
    assert_equal "SELECT \"users\".* FROM \"users\" WHERE \"users\".\"name\" REGEXP '^[^A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z]'", User.glyph_filter(:name, "?").to_sql
  end
  test "glyph passed is a regular glyph should do a like query" do
    assert_equal User.where("\"users\".\"name\" LIKE 'A%'").to_sql, User.glyph_filter(:name, "A").to_sql
  end
end
