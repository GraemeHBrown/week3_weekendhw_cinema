require_relative('../db/sql_runner.rb')

class Screening

  attr_reader :id
  attr_accessor :film_id, :time, :total_tickets_available
  def initialize(options)
    @id = options['id'].to_i
    @film_id = options['film_id'].to_i
    @time = options['time'].to_s
    @total_tickets_available = options['total_tickets_available']
  end

  def Screening.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    return screenings.map {|screening| Screening.new(screening)}
  end

  def Screening.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def Screening.find_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1;"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    screening_hash = results_array[0]
    screening = Screening.new(screening_hash)
    return screening
  end

  def save()
    sql = "INSERT INTO screenings
    (
      film_id,
      time,
      total_tickets_available
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@film_id, @time, @total_tickets_available]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def delete()
    sql = "DELETE FROM screenings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE screenings
    SET (
      film_id,
      time,
      total_tickets_available
      ) =
      (
        $1, $2, $3
      )
      WHERE id = $4"
      values = [@film_id, @time, @total_tickets_available, @id]
      SqlRunner.run(sql, values)
    end



end
