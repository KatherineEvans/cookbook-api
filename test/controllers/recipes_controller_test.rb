require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    User.create(name: "tiger", email: "tiger@test.com", password: "password")
    post "/sessions.json", params: {email: "tiger@test.com", password: "password"}
    data = JSON.parse(response.body)
    @jwt = data["jwt"]
  end

  test "index" do
    get "/recipes.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Recipe.count, data.length
  end

  test "show" do
    get "/recipes/#{Recipe.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "title", "chef", "ingredients", "directions", "prep_time", "image_url", "ingredients_list", "directions_list", "friendly_created_at", "friendly_prep_time"], data.keys
  end

  test "create" do
    assert_difference "Recipe.count", 1 do
      # create user, create jwt, use jwt in header
      post "/users.json", params: {name: "test", email: "test@test.com", password: "password", password_confirmation: "password"}
      post "/sessions.json", params: {email: "test@test.com", password: "password"}
      data = JSON.parse(response.body)
      jwt = data["jwt"]

      post "/recipes.json", 
        params: { title: "Cake", chef: "Jay Wengrow", prep_time: "hello", ingredients: "Batter", directions: "bake"},
        headers: {"Authorization" => "Bearer #{jwt}"}

      assert_response 200
    end
  end

  test "update" do
    recipe = Recipe.first
    patch "/recipes/#{recipe.id}.json", params: {title: "Updated title"},
    headers: {"Authorization" => "Bearer #{@jwt}"}
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated title", data["title"]
  end

  test "destroy" do
    assert_difference "Recipe.count", -1 do
      delete "/recipes/#{Recipe.first.id}.json",
      headers: {"Authorization" => "Bearer #{@jwt}"}
      assert_response 200
    end
  end
end