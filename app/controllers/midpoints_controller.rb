class MidpointsController < ApplicationController
	
  def index
    
  end

  def new
      @midpoint = Midpoint.new
      @midpoint.addresses =[Address.new, Address.new]
  end

  def create
    @midpoint = Midpoint.new(params.require(:midpoint).permit(addresses_attributes: [:id, :full_address]))
    @midpoint.save

    render "show"
  end

end
