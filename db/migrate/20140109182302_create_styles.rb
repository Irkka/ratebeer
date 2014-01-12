class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.integer :beer_id

      t.timestamps
    end
  end
end
