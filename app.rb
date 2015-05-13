require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

get('/') do
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/recipe_form') do
  erb(:recipe_form)
end

post('/recipes') do
  instructions = params.fetch('instructions')
  recipe_name = params.fetch('recipe_name')
  @recipe = Recipe.create(name: recipe_name, instructions: instructions)
  redirect('/recipes')
end

get('/recipe/:id') do
  @recipe = Recipe.find(params.fetch('id'))
  @ingredients = Ingredient.all()
  erb(:single_recipe)
end

post('/recipe/:id') do
  id = params.fetch('id')
  ingredient_name = params.fetch('ingredient_name')
  @ingredient = Ingredient.create(name: ingredient_name)
  recipe = Recipe.find(id)
  recipe.ingredients.push(@ingredient)
  redirect("recipe/#{id}")
end
