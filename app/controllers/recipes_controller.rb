class RecipesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  
  def index
    @recipes = Recipe.all
    render :index
  end

  def show
    @recipe = Recipe.find_by(id: params["id"])
    if @recipe
      render template: "recipes/show"
    else
      render json: {}
    end
  end

  def create
    @recipe = Recipe.create(
      title: params["title"], 
      chef: params["chef"], 
      prep_time: params["prep_time"], 
      ingredients: params["ingredients"], 
      directions: params["directions"],
      image_url: params["image_url"],
      user_id: current_user.id
    )
    if @recipe.save
      render :show
    else
      render json: {error: @recipe.errors.full_messages}, status: 422
    end
  end

  def update
    @recipe = Recipe.find_by(id: params["id"])
    @recipe.update(
      title: params["title"] || @recipe.title,
      chef: params["chef"] || @recipe.chef,
      image_url: params["image_url"] || @recipe.image_url,
      prep_time: params["prep_time"] || @recipe.prep_time, 
      ingredients: params["ingredients"] || @recipe.ingredients,
      directions: params["directions"] || @recipe.directions
    )
    if @recipe.save
      render :show
    else
      render json: {error: @recipe.errors.full_messages}, status: 422
    end
  end

  def destroy
    recipe = Recipe.find_by(id: params["id"])
    recipe.destroy
    render json: {message: "Recipe successfully destroyed"}
  end
end
