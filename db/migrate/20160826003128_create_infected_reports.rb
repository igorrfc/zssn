class CreateInfectedReports < ActiveRecord::Migration
  def change
    create_table :infected_reports do |t|
      t.integer :survivor_id

      t.timestamps null: false
    end
  end
end
