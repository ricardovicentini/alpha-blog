require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "Sports")
  end
  
  test "category should be valid" do
    assert @category.valid?
  end

  test "Category shoud have a name" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "Categroy name should be unique" do
    @category.name = "Sports"
    @category.save
    @category2 = Category.new(name: "Sports")
    assert_not @category2.valid?
  end

  test "Category name should not be grather than 25 char long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "Category name should not be las than 3 chars long" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end