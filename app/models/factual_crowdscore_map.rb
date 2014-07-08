class FactualCrowdscoreMap < ActiveRecord::Base

  validates :factual_category_id, uniqueness: true, presence: true
  validate :check_crowdscore_values
  
  
  private
  
  def check_crowdscore_values
    if venue_subcategory_id.blank? && venue_category_id.blank?
      errors.add :base, "You must include either a Crowdscore venue category or venue subcategory"
    end
  end

end
