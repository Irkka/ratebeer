class Beer < ActiveRecord::Base
		include RatingAverage

		attr_accessible :brewery_id, :name, :style_id

		belongs_to :brewery
		belongs_to :style
		has_many :ratings, :dependent => :destroy
		has_many :raters, through: :ratings, source: :user

		validates_presence_of :style
		validates_length_of :name, in: 1..20
		#validates :name, presence: true, allow_blank: false

		#def average_rating
				#if self.ratings.average("score").nil?
						#"N/A"
				#else
						#self.ratings.average("score").round(2)
				#end
		#end

		def to_s
				"#{self.name}/#{self.brewery.name}"
		end
end
