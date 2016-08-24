class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :description
      t.integer :points

      t.timestamps null: false
    end
  end
end
