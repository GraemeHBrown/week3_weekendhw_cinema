require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require('pry-byebug')

#Creating objects and saving them to db
customer1 = Customer.new({'name' => 'Fred', 'funds' => 20.00})
customer1.save()

film1 = Film.new({'title' => 'Lord of the Rings: Return of the King', 'price' => 8.25})
film1.save()

film2 = Film.new({'title' => 'Lord of the Rings: The Two Towers', 'price' => 8.50})
film2.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

#Getting all of the objects
all_tickets = Ticket.all()
all_films = Film.all()

binding.pry
nil
