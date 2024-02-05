require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  test "friendly_prep_time" do
    recipe = Recipe.new(prep_time: 200)
    assert_equal "3 hours and 20 minutes", recipe.friendly_prep_time
  end

  test "ingredients_list" do
    recipe = Recipe.new(ingredients: "one, two, three")
    assert_equal ["one", "two", "three"], recipe.ingredients_list
  end
end
