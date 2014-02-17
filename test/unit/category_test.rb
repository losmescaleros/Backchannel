require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # rather boring unit tests
  test "cannot save empty category" do
    cat = Category.new
    assert !(cat.save), "Category fields should not be empty or null"
  end
  test "category length >5" do
    cat = Category.new(
        name: "a"
    )
    cat2 = Category.new(
        name: "proper category length"
    )
    assert !(cat.save), "Category titles should be at least 5 characters"
    assert (cat2.save), "Category titles should be able to be more than 5 characters and less than 200"
  end
end
