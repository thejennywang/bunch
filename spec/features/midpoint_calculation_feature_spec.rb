require 'rails_helper'

describe "Midpoint Calculation" do
 
  context 'visiting homepage' do
 
    it 'should display the logo' do
      visit '/'
      
      expect(page).to have_content 'bunch'
    end
  
  end

end