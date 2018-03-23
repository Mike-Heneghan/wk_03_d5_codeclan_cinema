require("pry-byebug")

require_relative("sql_runner.rb")
require_relative("film.rb")
require_relative("ticket.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "
    INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id"

    values = [@name, @funds]

    result = SqlRunner.run(sql, values)
    @id = result[0]['id']

  end

  def self.get_customer_objects(result)
    answer = result.map { |customer_hash| Customer.new(customer_hash)}
    return answer
  end

  def self.all()
    sql = "
    SELECT * FROM customers"

    result = SqlRunner.run(sql)
    return Customer.get_customer_objects(result)
  end

  def self.delete_all()
    sql = "
    DELETE FROM customers"

    SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE customers
    SET (name, funds) = ($1,$2)
    WHERE id = $3"

    values = [@name, @funds, @id]

    result = SqlRunner.run(sql,values)
  end

  def delete()
    sql = "
    DELETE FROM customers WHERE id = $1"

    values = [@id]

    result = SqlRunner.run(sql,values)
  end

  def films_customer_has_booked()
    sql = "
    SELECT films.*
    FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE customer_id = $1;"

    values = [@id]

    result = SqlRunner.run(sql, values)
    return Film.get_film_objects(result)
  end
  # Show which films a customer has booked to see

end
