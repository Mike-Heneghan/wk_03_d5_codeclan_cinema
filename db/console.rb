require("pry-byebug")

require_relative("../models/customer")
require_relative("../models/film")
require_relative("../models/ticket")

Customer.delete_all()

customer1 = Customer.new('name'=>'Mike', 'funds'=>'30')

customer1.save()
customer1.funds = '45'
customer1.update()
# customer1.delete()
p Customer.all()
