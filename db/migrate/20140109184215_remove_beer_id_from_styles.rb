class RemoveBeerIdFromStyles < ActiveRecord::Migration
  def up
			remove_column :styles, :beer_id
  end

  def down
  end
end
