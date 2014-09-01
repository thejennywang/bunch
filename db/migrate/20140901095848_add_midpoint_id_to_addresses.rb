class AddMidpointIdToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :midpoint, index: true
  end
end
