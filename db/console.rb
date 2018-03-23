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

p Film.all()
puts ""

p Ticket.all()
puts ""
