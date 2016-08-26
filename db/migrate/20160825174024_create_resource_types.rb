class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.string :description
      t.integer :points

      t.timestamps null: false
    end
  end
end
