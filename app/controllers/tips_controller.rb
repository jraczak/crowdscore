class TipsController < InheritedResources::Base
  belongs_to :venue
  actions :index, :new, :create
  custom_actions resource: :upvote, collection: :sort
  before_filter :authenticate_user!, except: [:sort]

  respond_to :json, only: :index

  def index
    resource.current_user_id = current_user.try(:id)
  end

  def create
    build_resource.user = current_user
    create! { parent }
    
  end

  def upvote
    current_user.liked_tips << resource
    current_user.save!

    redirect_to resource.venue
  end
  
end
