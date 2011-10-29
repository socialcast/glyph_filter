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
    assert_equal User.where("users.name regexp '^[^#{(("A".."Z").to_a + ("a".."z").to_a).join("|")}]'").to_sql, User.glyph_filter(:name, "?").to_sql
  end
  test "glyph passed is a regular glyph should do a like query" do
    assert_equal User.where("users.name LIKE 'A%'").to_sql, User.glyph_filter(:name, "A").to_sql
  end
end
