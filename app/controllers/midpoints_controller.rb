class MidpointsController < ApplicationController
	
  def index
    
  end

  def new

  end

  def create
    puts params.inspect
    Address.create(_nth_address_details(1, params))
    Address.create(_nth_address_details(2, params))
    render "show"
  end

  def _nth_address_details(n, params)
    { 
      :full_address => params["full_address_#{n}".to_sym], 
      :lat => params["lat_#{n}".to_sym].to_f, 
      :lng => params["lng_#{n}".to_sym].to_f
    }
  end

end
