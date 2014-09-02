class AddColumnsToMidpoint < ActiveRecord::Migration
  def change
  	add_column :midpoints, :lat, :float
  	add_column :midpoints, :lng, :float
  end
end
