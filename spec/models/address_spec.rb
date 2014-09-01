require 'rails_helper'

RSpec.describe Address, :type => :model do
  context "With a valid address" do

      let (:address) { Address.create(full_address: '25 City Rd') }

    xit 'returns a longitude' do

    end

  end
end
