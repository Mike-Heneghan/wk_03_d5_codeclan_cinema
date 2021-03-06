require("pry-byebug")

require_relative("../models/customer")
require_relative("../models/film")
require_relative("../models/ticket")

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new('name'=>'Mike', 'funds'=>'30')
customer1.save()
customer1.funds = '45'
customer1.update()
# customer1.delete()

film1 = Film.new('title'=>'Memento', 'price'=>'12')
film1.save()
film1.price = '11'
film1.update()

ticket1 = Ticket.new('film_id'=> film1.id, 'customer_id'=> customer1.id)
ticket1.save()


p Customer.all()
puts ""

p customer1.films_customer_has_booked()
puts ""

p Film.all()
puts ""

p film1.customers_who_booked_film()
puts ""

p Ticket.all()
puts ""

p film1.number_of_customers()
puts ""

p customer1.number_of_tickets()
puts ""

# p ticket1.customer_buys_ticket()
# # p Customer.all()
Customer.customer_buys_ticket(customer1)

p Customer.all()
puts ""
