require_relative('../db/sql_runner')

class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @id = options['id'].to_i if options['id']
  end

  def self.all()
    sql = "SELECT * FROM stars"
    values = []
    stars = SqlRunner.run(sql, values)
    return stars.map{|star| Star.new(star) }
  end

  def self.delete_all()
    sql = "DELETE * FROM stars"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO stars (first_name, last_name) VALUES ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    star = SqlRunner.run(sql, values).first
    @id = star['id'].to_i
  end

  def update()
    sql = "UPDATE movies SET (first_name, last_name) VALUES ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM stars WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end



  def movies()
    sql = "SELECT movies.*
          FROM movies
          INNER JOIN castings
          ON movies.id = castings.movie_id
          WHERE star_id = $1"
    values = [@id]
    movies = SqlRunner.run(sql, values)
    return movies.map { |movie| Movie.new(movie) }
  end

end
