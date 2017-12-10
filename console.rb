require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')
require('pry-byebug')

###Class methods for deleting all
Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()

###Creating objects and saving them to db
customer1 = Customer.new({'name' => 'Fred', 'funds' => 20.00})
customer1.save()

customer2 = Customer.new({'name' => 'Joe', 'funds' => 35.00})
customer2.save()

customer3 = Customer.new({'name' => 'Eric', 'funds' => 15.00})
customer3.save()

film1 = Film.new({'title' => 'Lord of the Rings: Return of the King', 'price' => 8.25})
film1.save()

film2 = Film.new({'title' => 'Lord of the Rings: The Two Towers', 'price' => 8.50})
film2.save()

film3 = Film.new({'title' => 'Lord of the Rings: The Fellowship of the Ring', 'price' => 8.75})
film3.save()

screening1 = Screening.new({'film_id' => film1.id, 'time' => '17:00', 'total_tickets_available' => 40})
screening1.save()

screening2 = Screening.new({'film_id' => film2.id, 'time' => '20:00', 'total_tickets_available' => 50})
screening2.save()

screening3 = Screening.new({'film_id' => film3.id, 'time' => '19:00', 'total_tickets_available' => 50})
screening3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening2.id})
ticket2.save()

ticket3 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening1.id})
ticket3.save()

ticket4 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening3.id})
ticket4.save()



###Getting all of the objects
all_tickets = Ticket.all()
all_films = Film.all()
all_customers = Customer.all()
all_screenings = Screening.all()

###delete one
# customer2.delete()
# film2.delete()
# ticket2.delete()
# screening3.delete()

###update
# ticket1.film_id = film2.id
ticket1.update()
film2.price = 9.00
film2.update()
customer1.name = 'Jane'
customer1.update()
screening3.time = '19:15'
screening3.update()

###find_by_id class methods
found_ticket = Ticket.find_by_id(ticket1.id)
found_film = Film.find_by_id(film1.id)
found_customer = Customer.find_by_id(customer1.id)
found_screening = Screening.find_by_id(screening1.id)

# ###find films for customer
# found_films = customer1.films_for_customer()
#
### find customers for a film
found_customers = film1.customers_for_film()

# ### buying tickets reduces customer funds
# customer1.buying_ticket_reduces_customer_funds()
#
# ### check how many tickets were bought by customer
# #note this is implemented as class method but could also be an
# # instance method
# ticket_count = Customer.ticket_count(customer1.id)
#
# ###check how many customers are going to a particular film
# found_customers_for_film = film2.customers_for_film()
# customer_count_expected = found_customers_for_film.size()
# customer_count_actual = film2.customer_count_for_film()
# test_result = false
# if customer_count_expected == customer_count_actual
#   test_result = true
# end
# p "Customer count for film method working?: #{test_result}"

binding.pry
nil
