class UsersController < InheritedResources::Base
  include ActionView::Helpers::TextHelper
  actions :show
  custom_actions member: [:follow]

  before_filter :authenticate_user!, only: [:follow]

  #def create
  #  if @user.was_invited?
  #    @user = User.find_by_email(params[:email])
  #    redirect_to accept_user_invitation_path(:invitation_token => @user.invitation_token)
  #  else
  #    @user.username = @user.username.downase
  #    create!
  #  end
  #end
    
  def show
    #@user = User.find_by_permalink(params[:id])
    @user = User.find_by_permalink(params[:id])
  end
  
  def follow
    tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_PROJECT_TOKEN'])
    if current_user == resource
      flash[:notice] = "Whoops. You can't follow yourself."
    elsif current_user.follows?(resource)
      flash[:notice] = "You are already following #{resource.username}!"
    else
      current_user.follows << resource
      flash[:notice] = "You are now following #{resource.username}!"
      tracker.track(current_user.id, 'Followed User')
      # Send a notification email to the user saying they were followed.
      unless !resource.receive_follower_emails
        FollowsMailer.new_follower_email(resource, current_user).deliver
      end
    end

    redirect_to "/users/#{resource.username.downcase}"
  end
  
  def unfollow
    Follow.where(followed_id: resource.id, follower_id: current_user.id).first.delete
    #resource.follows.where(follower_id = current_user.id)
    flash[:notice] = "You are no longer following #{resource.username}"
    redirect_to "/users/#{resource.username.downcase}"
  end
  
  def add_liked_venue_categories
    params[:venue_subcategories].each do |vsc|
      current_user.liked_venue_categories[params[:venue_category_name]] << vsc
    end
    user.save!
  end
  
  def set_user_locale
    
  end
  
  def onboard_user
    p params
    venue_subcategory_integers = []
    params[:venue_subcategories].each do |vsc|
      vsc = vsc.to_i
      venue_subcategory_integers << vsc
    end
    current_user.liked_venue_categories[params[:venue_category_name]] = venue_subcategory_integers
    #end
    current_user.home_city = params[:city]
    current_user.home_state = params[:state]
    # This needs to be refactored to properly update onboarding only if user is saved.
    current_user.onboarded = true
    current_user.save!
  end
  
  def batch_invite
    #Validate the user_emails field isn't blank and emails are valid
    emails = [params[:invitation_email1], params[:invitation_email2], params[:invitation_email3], params[:invitation_email4],params[:invitation_email5]]
    #params[:invitation_emails].split(",").each do |email|
    non_empty_emails = 0
    emails.each do |email|
      unless email.empty?
        User.invite!({:email => email}, current_user)
        non_empty_emails += 1
        current_user.add_points(1, "1 karma point added for inviting user")
      end
    end
    flash[:notice] = "Your invitations are on the way! You earned #{ pluralize(non_empty_emails, 'karma point') } for sharing the love."
    redirect_to '/dashboard'
  end
    
  
end