require_relative('models/movie')
require_relative('models/star')
require_relative('models/casting')

require('pry-byebug')

movie1 = Movie.new( {'title' => 'star_wars', 'genre' => 'action', 'budget' => 20} )
movie1.save()
movie2 = Movie.new( {'title' => 'deadpool', 'genre' => 'action', 'budget' => 20} )
movie2.save()

star1 = Star.new( {'first_name' => 'Mark', 'last_name' => 'Hammell'} )
star1.save()
star2 = Star.new( {'first_name' => 'Ryan', 'last_name' => 'Reynolds'} )
star2.save()

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 5} )
casting2 = Casting.new({'movie_id' => movie1.id, 'star_id' => star2.id, 'fee' => 10} )

casting1.save
casting2.save

binding.pry
nil
