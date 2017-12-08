require_relative('./models/customer.rb')
require('pry-byebug')


customer1 = Customer.new({'name' => 'Fred', 'funds' => 20.00})

customer1.save()

binding.pry
nil
