require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_f
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map{|customer| Customer.new(customer)}
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def Customer.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    customer_hash = results_array[0]
    customer = Customer.new(customer_hash)
    return customer
  end

  def Customer.ticket_count(id)
    sql = "SELECT COUNT(tickets)
    FROM tickets
    WHERE tickets.customer_id = $1;"
    values = [id]
    results_hash = SqlRunner.run(sql, values).first
    return results_hash['count'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers
    SET (
      name,
      funds
      ) =
      (
        $1, $2
      )
      WHERE id = $3"
      values = [@name, @funds, @id]
      SqlRunner.run(sql, values)
    end

    def films_for_customer()
      sql = "SELECT DISTINCT films.*
      FROM films
      INNER JOIN screenings ON screenings.film_id = films.id
      INNER JOIN tickets ON tickets.screening_id = screenings.id
      WHERE tickets.customer_id = $1;"
      values = [@id]
      film_hashes = SqlRunner.run(sql, values)
      return film_hashes.map{|film| Film.new(film)}
    end

    def buying_ticket_reduces_customer_funds()
      customer_films = films_for_customer()
      price_of_all_films = 0
      for film in customer_films
        price_of_all_films += film.price
      end
      current_funds = @funds
      if current_funds >= price_of_all_films
        @funds -= price_of_all_films
        update()
      end
    end

  end
