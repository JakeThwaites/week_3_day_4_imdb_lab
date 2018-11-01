require_relative('../db/sql_runner')

class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO MOVIES (title, genre) VALUES ($1, $2) RETURNING id"
    values = [@title, @genre]
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

end
