require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require('pry-byebug')

#Saving objects to db
customer1 = Customer.new({'name' => 'Fred', 'funds' => 20.00})
customer1.save()

film1 = Film.new({'title' => 'Lord of the Rings', 'price' => 8.25})
film1.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

#Getting all of the objects
all_tickets = Ticket.all()

binding.pry
nil
