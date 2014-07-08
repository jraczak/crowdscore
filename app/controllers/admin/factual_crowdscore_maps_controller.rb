class Admin::FactualCrowdscoreMapsController < InheritedResources::Base
  
  actions :new, :create, :show
  
  def new
    @factual_crowdscore_map = FactualCrowdscoreMap.new
  end
  
  def show
  end
    
  def create
    @factual_crowdscore_map = FactualCrowdscoreMap.new(params[:factual_crowdscore_map])
    if @factual_crowdscore_map.venue_subcategory_id?
      @vsi = VenueSubcategory.find(@factual_crowdscore_map.venue_subcategory_id).venue_category_id
      @factual_crowdscore_map.venue_category_id = VenueCategory.find(@vsi)
    end
    #@factual_crowdscore_map = FactualCrowdscoreMap.new (params[:factual_crowdscore_map])
    #if params[:venue_category_id].present?
    #  @factual_crowdscore_map.venue_category_id = params[:venue_category_id]
    #  @factual_crowdscore_map.factual_category_id = params[:factual_category_id]
    #  @factual_crowdscore_map.description = params[:description]
    #else
    #  @factual_crowdscore_map.venue_subcategory_id = params[:venue_subcategory_id]
    #  @factual_crowdscore_map.venue_category_id = VenueCategory.find(VenueSubcategory.find(params[:venue_subcategory_id]).venue_category_id)
    #  @factual_crowdscore_map.description = params[:description]
    #end
    if @factual_crowdscore_map.save
      #@factual_crowdscore_map.venue_category_id = VenueCategory.find(VenueSubcategory.find(@factual_crowdscore_map.venue_subcategory_id).venue_category_id)
      flash[:success] = "New map created"
      redirect_to admin_factual_crowdscore_maps_path
    else
      render :action => 'new'
    end
  end
  
end