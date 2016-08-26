class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :inventory, index: true, foreign_key: true
      t.references :resource_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
