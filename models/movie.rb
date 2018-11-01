require_relative('../db/sql_runner')

class Movie

  attr_accessor :title, :genre, :budget
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @budget = options['budget']
  end

  def save()
    sql = "INSERT INTO MOVIES (title, genre, budget) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @budget]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM MOVIES"
    values = []
    all = SqlRunner.run(sql, values)
    return all.map{|movie| Movie.new(movie) }
  end

  def stars()
    sql = "SELECT stars.*
  FROM stars
  INNER JOIN castings
  ON stars.id = castings.star_id
  WHERE movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql, values)
    return stars.map { |star| Star.new(stars) }
  end

  def remaining_budget()

    sql = "SELECT SUM(castings.fee)
          FROM castings
          INNER JOIN movies
          ON movies.id = castings.movie_id
          WHERE movie_id = $1"
    values = [@id]
    total_fee = SqlRunner.run(sql, values).first['sum']

    # remaining = total_fee.map { |fee| Movie.new(fee) }
    return @budget - total_fee
  end

end
