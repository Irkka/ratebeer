#!/usr/bin/env ruby
#
# rating_average.rb
# Ilkka Hakkarainen <ilkka.hakkarainen@cs.helsinki.fi>
#
# Distributed under terms of the WTFPL license.
#


module RatingAverage

		def average_rating
				sum = self.ratings.inject 0.0 do |result, element|
						result += element.score
				end
				sum / self.ratings.count
		rescue
				"N/A"
		end

end

