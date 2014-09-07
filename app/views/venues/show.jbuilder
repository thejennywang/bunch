@venues.each do |venue|
puts venue.name
  json.venue do
     json.name venue.name
     json.address venue.address
  end
end

json.venues 