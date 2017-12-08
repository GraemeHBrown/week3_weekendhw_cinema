require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require('pry-byebug')

#Saving objects to db
customer1 = Customer.new({'name' => 'Fred', 'funds' => 20.00})
customer1.save()

film1 = Film.new({'title' => 'Lord of the Rings', 'price' => 8.25})
film1.save()



binding.pry
nil
