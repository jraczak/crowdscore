module UserControllerAdditions
  extend ActiveSupport::Concern


  
  module ClassMethods
    def migrate_user_liked_venue_categories_to_cuisines(user)
      ids = []
      user.liked_venue_categories["restaurant"].each do |id|
        ids << VenueSubcategory.find(id).name
      end
      user.liked_venue_categories["restaurant"] = ids
      user.save!
    end
  end
  

  
end