# i run this file
# i get 20 dummy dish in my app

require 'pg'
require_relative '../models/dish'


choices_a = ['pudding', 'cake', 'muffin']
choices_b = ['ripper', 'banana', 'beef', 'fairy floss']

10.times do
  create_dish(
    "#{choices_b.sample} #{choices_a.sample}", 
    'https://via.placeholder.com/600'
  )
end