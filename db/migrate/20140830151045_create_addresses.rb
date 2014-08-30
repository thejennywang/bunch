class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :full_address
      t.text :postcode

      t.timestamps
    end
  end
end
