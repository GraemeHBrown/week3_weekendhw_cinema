require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_f
  end

  def Film.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map {|film| Film.new(film)}
  end

  def Film.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def Film.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    film_hash = results_array[0]
    film = Film.new(film_hash)
    return film
  end

  def Film.find_most_popular_time(id)
    sql = "SELECT COUNT(*) as tickets_sold, screenings.time as screening_time
    FROM tickets
    INNER JOIN screenings
    ON screenings.id = tickets.screening_id
    WHERE screenings.film_id = $1
    GROUP BY screenings.time"
    values = [id]
    results = SqlRunner.run(sql, values)
    most_popular_result = results.max_by{|k,v| v}
    return most_popular_result['screening_time']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films
    SET (
      title,
      price
      ) =
      (
        $1, $2
      )
      WHERE id = $3"
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
    end

    def customers_for_film()
      sql = "SELECT customers.*
      FROM customers
      INNER JOIN tickets ON tickets.customer_id = customers.id
      INNER JOIN screenings ON tickets.screening_id = screenings.id
      WHERE screenings.film_id = $1"
      values = [@id]
      customer_hashes = SqlRunner.run(sql, values)
      return customer_hashes.map{|customer| Customer.new(customer)}
    end

    def customer_count_for_film()
      return customers_for_film.size()
    end


end
