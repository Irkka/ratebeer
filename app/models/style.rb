class Style < ActiveRecord::Base
  attr_accessible :beer_id, :description, :name

	has_many :beers

	def to_s
			name
	end
end
