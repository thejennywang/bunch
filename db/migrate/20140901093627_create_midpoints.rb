class CreateMidpoints < ActiveRecord::Migration
  def change
    create_table :midpoints do |t|

      t.timestamps
    end
  end
end
