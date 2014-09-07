json.venues @venues do |venue|
     json.name venue.name
     json.fullAddress venue.full_address
     json.lat venue.lat
     json.lng venue.lng
     json.category venue.category
     json.priceTier venue.price_tier
     json.rating venue.rating
     json.id venue.id
  end

