require("pry-byebug")

require_relative("customer.rb")
require_relative("sql_runner.rb")
require_relative("ticket.rb")

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "
    INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id"

    values = [@title, @price]

    result = SqlRunner.run(sql, values)
    @id = result[0]['id']

  end

  def self.get_film_objects(result)
    answer = result.map { |film_hash| Film.new(film_hash)}
    return answer
  end

  def self.all()
    sql = "
    SELECT * FROM films"

    result = SqlRunner.run(sql)
    return Film.get_film_objects(result)
  end

  def self.delete_all()
    sql = "
    DELETE FROM films"

    SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE films
    SET (title, price) = ($1,$2)
    WHERE id = $3"

    values = [@title, @price, @id]

    result = SqlRunner.run(sql,values)
  end

  def delete()
    sql = "
    DELETE FROM films WHERE id = $1"

    values = [@id]

    result = SqlRunner.run(sql,values)
  end

  def customers_who_booked_film()
    sql = "
    SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1;
    "

    values = [@id]

    result = SqlRunner.run(sql,values)
    return Customer.get_customer_objects(result)
  end

  def number_of_customers()
    return customers_who_booked_film.length
  end
  # Check how many customers are going to watch a certain film

end
