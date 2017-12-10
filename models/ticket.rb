require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :screening_id
  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def Ticket.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return tickets.map {|ticket| Ticket.new(ticket)}
  end

  def Ticket.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def Ticket.find_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1;"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    ticket_hash = results_array[0]
    ticket = Ticket.new(ticket_hash)
    return ticket
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      screening_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def delete()
    sql = "DELETE FROM tickets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE tickets
    SET (
      customer_id,
      screening_id
      ) =
      (
        $1, $2
      )
      WHERE id = $3"
      values = [@customer_id, @screening_id, @id]
      SqlRunner.run(sql, values)
    end

  end
