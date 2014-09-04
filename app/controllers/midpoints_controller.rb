require 'calculators/midpoint_calculator'

class MidpointsController < ApplicationController
	
  def index
    #User saved searches?
  end

  def new

  end

  def create
    addresses = _create_addresses(params[:addresses])
    coordinates = addresses.map{ |address| Coordinate.create_from(address) }
    midpoint = _create_midpoint_from(coordinates)
    _create_associations(midpoint, addresses)
    redirect_to midpoint_path(midpoint)
  end

  def show
    @midpoint = Midpoint.find(params[:id])
  end

  def _nth_address_details(n, addresses)
    { 
      :full_address => addresses[n]["full_address"], 
      :lat => addresses[n]["lat"].to_f, 
      :lng => addresses[n]["lng"].to_f
    }
  end

  def _create_addresses(params)
    addresses = []
    params.length.times { |i| addresses << Address.create(_nth_address_details(i, params)) }
    addresses
  end

  def _create_associations(midpoint, child_addresses)
    child_addresses.each { |child_address| midpoint.addresses << child_address }
  end

  def _create_midpoint_from(coordinates, metric=:distance)
    midpoint_coordinates = MidpointCalculator.midpoint_by(metric, coordinates)
    Midpoint.create(lat: midpoint_coordinates.lat, lng: midpoint_coordinates.lng)
  end

end
