class Brewery < ActiveRecord::Base
		include RatingAverage

		attr_accessible :name, :year

		has_many :beers
		has_many :ratings, through: :beers

		validates_uniqueness_of :name
		#validates_numericality_of :year, {greater_than_or_equal_to: 1042, less_than_or_equal_to: 2014}
		validates_length_of :name, in: 1..20, allow_blank: false
		validate :year_cannot_be_less_than, :year_cannot_be_more_than

		def year_cannot_be_less_than
				if year.present? and not year >= 1042
						errors.add(:year, "No brewery could've existed before that!")
				end
		end

		def year_cannot_be_more_than
				if year.present? and year > Time.now.year
						errors.add(:year, "Your brewery will have been founded in the future")
				end
		end
end
