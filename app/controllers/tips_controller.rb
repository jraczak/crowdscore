class TipsController < InheritedResources::Base
  belongs_to :venue
  actions :new, :create
  custom_actions resource: :upvote, collection: :sort
  before_filter :authenticate_user!

  def create
    build_resource.user = current_user
    create!
  end

  def upvote
    current_user.liked_tips << resource
    current_user.save!

    redirect_to resource.venue
  end

  def sort
    if params[:sort] == 'popularity'
      render partial: 'tips/tip', collection: collection.by_likes
    else
      render partial: 'tips/tip', collection: collection.by_recent
    end
  end
end
