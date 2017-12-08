require_relative('../db/sql_runner.rb')

class Film

attr_reader :id
attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_f
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

end