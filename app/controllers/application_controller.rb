class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get "/recipes" do
    # binding.pry
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end

  post "/recipes" do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end


  get "/recipes/:id" do
     @recipe = Recipe.find_by(id: params[:id])
    erb :show
  end

  get "/recipes/:id/delete" do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.delete
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit
  end


  # get "/recipes/:id/update" do
  #   @recipe = Recipe.find_by(id: params[:id])
  #   erb :update
  # end
  #
  # post "recipes/:id/update" do
  #   @recipe = Recipe.find_by(id: params[:id])
  #   @recipe.name = params[:name]
  #   @recipe.ingredients = params[:ingredients]
  #   @recipe.cook_time = params[:cook_time]
  #   @recipe.save
  #   redirect "/recipes/#{@recipe.id}"
  # end

end
