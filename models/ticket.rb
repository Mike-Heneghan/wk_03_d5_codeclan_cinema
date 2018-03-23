require('pry-byebug')

require_relative("film")
require_relative("customer")
require_relative("sql_runner")

class Ticket
  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize( options )
    @id = options['id']
    @film_id = options['film_id']
    @customer_id = options['customer_id']
  end

  def save()
    sql = "
    INSERT INTO tickets (film_id, customer_id)
    VALUES ($1, $2)
    RETURNING id"

    values = [@film_id, @customer_id]

    result = SqlRunner.run(sql, values)
    @id = result[0]['id']

  end

  def self.get_ticket_objects(result)
    answer = result.map { |ticket_hash| Ticket.new(ticket_hash)}
    return answer
  end

  def self.all()
    sql = "
    SELECT * FROM tickets"

    result = SqlRunner.run(sql)
    return Ticket.get_ticket_objects(result)
  end

  def self.delete_all()
    sql = "
    DELETE FROM tickets"

    SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE tickets
    SET (film_id, customer_id) = ($1,$2)
    WHERE id = $3"

    values = [@film_id, @customer_id, @id]

    result = SqlRunner.run(sql,values)
  end

  def delete()
    sql = "
    DELETE FROM tickets WHERE id = $1"

    values = [@id]

    result = SqlRunner.run(sql,values)
  end



















end
