require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require('pry-byebug')

###Class methods for deleting all
Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

###Creating objects and saving them to db
customer1 = Customer.new({'name' => 'Fred', 'funds' => 20.00})
customer1.save()

customer2 = Customer.new({'name' => 'Joe', 'funds' => 35.00})
customer2.save()

film1 = Film.new({'title' => 'Lord of the Rings: Return of the King', 'price' => 8.25})
film1.save()

film2 = Film.new({'title' => 'Lord of the Rings: The Two Towers', 'price' => 8.50})
film2.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()

###Getting all of the objects
all_tickets = Ticket.all()
all_films = Film.all()
all_customers = Customer.all()

###delete one
# customer2.delete()
# film2.delete()
# ticket2.delete()

###update
ticket1.film_id = film2.id
ticket1.update()
film2.price = 9.00
film2.update()

binding.pry
nil
