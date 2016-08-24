class ChangeInfectedDefaultValueOnSurvivors < ActiveRecord::Migration
  def change
    change_column :survivors, :infected, :boolean, :default => false
  end
end
