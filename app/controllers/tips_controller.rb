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
    tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_PROJECT_TOKEN'])
    build_resource.user = current_user
    create! { 
      respond_to do |format|
        format.html { parent }
        format.js { render "create", :locals => {:tip => build_resource} }
      end 
      tracker.track(current_user.id, 'Posted Tip')
      return
    }
    flash[:notice] = "You've earned 1 Karma point for submitting your tip!"
  end

  def upvote
    unless current_user.liked_tips.include?(resource)
      current_user.liked_tips << resource
      current_user.save!
    end

    respond_to do |format|
      format.html { redirect_to resource.venue }
      format.js { render "upvote", :locals => {:tip => resource} }
    end
    
  end
  
  def remove_vote
    current_user.liked_tips.delete(resource)
    current_user.save!

    respond_to do |format|
      format.html { redirect_to resource.venue }
      format.js { render "remove_vote", :locals => {:tip => resource} }
    end
  end
  
end
