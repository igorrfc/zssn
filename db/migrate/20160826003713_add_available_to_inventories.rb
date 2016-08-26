class AddAvailableToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :available, :boolean , :default => true
  end
end
