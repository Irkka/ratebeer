class Beer < ActiveRecord::Base
	attr_accessible :brewery_id, :name, :style

	belongs_to :brewery
	has_many :ratings

	def average_rating
		@ratings = self.ratings
		if @ratings.count.!=0
			total = 0
			@ratings.each do |rating|
				total += rating.score	
			end
			total = total / ratings.count
			total
		else
			0
		end
	end
end
