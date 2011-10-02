module VenueControllerAdditions
  extend ActiveSupport::Concern

  included do
    before_filter :setup_subcategories_for_new_record, :only => [:new, :create]
    before_filter :setup_subcategories_for_persisted_record, :only => [:edit, :update]
  end

  private

  def setup_subcategories_for_new_record
    setup_subcategories(build_resource)
  end

  def setup_subcategories_for_persisted_record
    setup_subcategories(resource)
  end

  def setup_subcategories(resource_for_action)
    @venue_subcategories = resource_for_action.venue_category.venue_subcategories
  rescue
    @venue_subcategories = []
  end
end
