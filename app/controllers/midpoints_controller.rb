class MidpointsController < ApplicationController
	
  def index
    
  end

  def new

  end

  def create
    puts params.inspect
    @midpoint = Midpoint.new(params.require(:midpoint).permit(addresses_attributes: [:id, :full_address]))
    @midpoint.save
    puts @midpoint.addresses
    render "show"
  end

end
