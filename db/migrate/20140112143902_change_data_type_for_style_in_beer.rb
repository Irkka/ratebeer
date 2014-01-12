class ChangeDataTypeForStyleInBeer < ActiveRecord::Migration
  def up
			change_table :beers do |t|
				  t.change :style, :integer
					t.rename :style, :style_id
			end
  end

  def down
			change_table :beers do |t|
					t.rename :style_id, :style
					t.change :style, :string
			end
  end
end
