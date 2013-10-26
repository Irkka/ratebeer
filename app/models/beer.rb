class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
end
