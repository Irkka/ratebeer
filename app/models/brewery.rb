class Brewery < ActiveRecord::Base
  attr_accessible :name, :year

  has_many :beers
end
