module ListsHelper

def preview_card_venues(list)
  list.venues.first(3)
end

end
