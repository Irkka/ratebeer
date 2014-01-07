class User < ActiveRecord::Base
		include RatingAverage

		attr_accessible :username, :password, :password_confirmation
		has_secure_password

		has_many :ratings, dependent: :destroy
		has_many :beers, through: :ratings
		has_many :memberships
		has_many :beer_clubs, through: :memberships

		validates_uniqueness_of :username
		validates_length_of :username, in: 3..15, allow_blank: false
		validates_length_of :password, minimum: 4
		validates :password, format: /[\w\W]*[\W[:digit:]][\w\W]*/

		def favorite_beer
				return nil if ratings.empty?
				ratings.sort_by{ |r| r.score }.last.beer
		end

		def favorite_style
				styles = beers.collect { |b| b.style }.uniq
				style_scores = Hash.new
				styles.each do |s|
						beer_count = beers.where(:style => s).count
						style_total = beers.where(:style => s).collect { |b| b.ratings }.flatten.inject(0) {|result, rating| result + rating.score }
						#binding.pry
						style_scores[s] = style_total / beer_count
				end
				#binding.pry
				style_scores.max_by{|k,v| v}[0]
		rescue
				"no beers rated yet"
		end

		def favorite_brewery
				#binding.pry
				breweries = beers.collect { |b| b.brewery }.uniq
				brewery_scores = Hash.new
				breweries.each do |b|
						beer_count = beers.where(:brewery_id => b).count
						brewery_total = beers.where(:brewery_id => b).collect { |beer| beer.ratings }.flatten.inject(0) {|result, rating| result + rating.score }
						brewery_scores[b] = brewery_total / beer_count
				end
				brewery_scores.max_by{|k,v| v}[0].name
		rescue
				"no beers rated yet"
		end
end
