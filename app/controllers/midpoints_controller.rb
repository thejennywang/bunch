require 'calculators/midpoint_calculator'

class MidpointsController < ApplicationController

  def create
    redirect_to midpoint_path(Midpoint.create_from(params[:addresses]))
  end

  def show
    @midpoint = Midpoint.find(params[:id])
  end

end
