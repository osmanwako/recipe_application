# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

str = 'Food contains nutrientssubstances essential for the growth, repair, and maintenance of body tissues and for the regulation of vital processes. Nutrients provide the energy our bodies need to function'
users = User.all
for s in 1..6
  food = Food.create({ name: "Food #{rand(1000)}", measurement_unit: 'grams', price: rand(2300), quantity: rand(20),
                       user: users[rand(users.length)] })
  recipe = Recipe.create({ name: "Recipe #{rand(1000)}", preparation_time: "#{rand(10)} hours",
                           cooking_time: "#{rand(120)} minutes", description: str, public: rand(2) == 1, user: users[rand(users.length - 1)] })
  shopping = Recipefood.create(quantity: rand(20), recipe:, food:)
end
recipes = Recipe.all
foods = Food.all
for s in 1..6
  shopping = Recipefood.create(quantity: rand(20), recipe: recipes[rand(recipes.length - 1)],
                               food: foods[rand(foods.length - 1)])
end
