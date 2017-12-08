require_relative('../db/sql_runner.rb')

class Film

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_f
  end


end
