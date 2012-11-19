class VenuesController < InheritedResources::Base
  include VenueControllerAdditions
  actions :index, :show, :new, :create, :edit, :update
  before_filter :authenticate_user!, except: [:index, :show, :search]

  def search
    if params[:zip].blank? && params[:latitude].blank?
      flash[:notice] = 'You must include a location to search.'
      return redirect_to(root_path)
    end

    @venues = VenueSearch.search(params)
  end
  
  def get_tag_categories
    @venue ||= Venue.active.find(params[:id])
    tag_categories = []
    @venue.tags.each do |t|
      unless tag_categories.include?(t.name)
        tag_categories << t.name
      end
    end
    tag_categories
  end

  private

  def collection
    @venues ||= Venue.active.alphabetical.page(params[:page])
  end

  def resource
    @venue ||= Venue.active.find(params[:id])
  end

  def as_role
    resource.presisted? ? { as: :regular_user_editing } : super
  end
  
end
