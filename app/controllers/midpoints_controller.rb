require 'calculators/midpoint_calculator'

class MidpointsController < ApplicationController
	
  def index
    #User saved searches?
  end

  def new

  end

  def create
    redirect_to midpoint_path(Midpoint.create_from(params[:addresses]))
  end

  def show
    @midpoint = Midpoint.find(params[:id])
  end

  
  

end
