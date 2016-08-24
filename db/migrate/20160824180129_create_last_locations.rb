class CreateLastLocations < ActiveRecord::Migration
  def change
    create_table :last_locations do |t|
      t.float :latitude
      t.float :longitude
      t.references :survivor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
