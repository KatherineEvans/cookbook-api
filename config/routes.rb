Rails.application.routes.draw do
  # RECIPES
  # index route/action
  get "/recipes" => "recipes#index"
  # show route/action
  get "/recipes/:id" => "recipes#show"
  # create route/action
  post "/recipes" => "recipes#create"
  # patch route/action
  patch "/recipes/:id" => "recipes#update"
  # destory route/action
  delete "/recipes/:id" => "recipes#destroy"

  # USERS
  post "/users" => "users#create" # sign up
  post "/sessions" => "sessions#create" #log in

end
