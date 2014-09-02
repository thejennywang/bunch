class UpdateColumnsForAddress < ActiveRecord::Migration
  def change
  	add_column :addresses, :lat, :float
  	add_column :addresses, :lng, :float
  	remove_column :addresses, :postcode
  end
end
