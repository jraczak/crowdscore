class VenuesController < InheritedResources::Base
  actions :index, :show, :new, :create
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :setup_venue_subcategories, :only => [:new, :create]

  private

  def collection
    @venues ||= end_of_association_chain.page(params[:page])
  end

  def setup_venue_subcategories
    @venue_subcategories = build_resource.venue_category.venue_subcategories
  rescue
    @venue_subcategories = []
  end
end
