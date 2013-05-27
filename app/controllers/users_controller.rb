class UsersController < InheritedResources::Base
  actions :show
  custom_actions member: [:follow]

  before_filter :authenticate_user!, only: [:follow]

  def show
    #@user = User.find_by_permalink(params[:id])
    @user = User.find_by_permalink(params[:id])
  end
  
  def follow
    if current_user == resource
      flash[:notice] = "Whoops. You can't follow yourself."
    elsif current_user.follows?(resource)
      flash[:notice] = "You are already following #{resource.username}!"
    else
      current_user.follows << resource
      flash[:notice] = "You are now following #{resource.username}!"
      # Send a notification email to the user saying they were followed.
      FollowsMailer.new_follower_email(resource, current_user).deliver
    end

    redirect_to "/users/#{resource.username.downcase}"
  end
  
  def unfollow
    Follow.where(followed_id: resource.id, follower_id: current_user.id).first.delete
    #resource.follows.where(follower_id = current_user.id)
    flash[:notice] = "You are no longer following #{resource.username}"
    redirect_to "/users/#{resource.username.downcase}"
  end
  
  def batch_invite
    #Validate the user_emails field isn't blank and emails are valid
    emails = [params[:invitation_email1], params[:invitation_email2], params[:invitation_email3], params[:invitation_email4],params[:invitation_email5]]
    #params[:invitation_emails].split(",").each do |email|
    emails.each do |email|
      User.invite!({:email => email}, current_user)
    end
    flash[:notice] = "Your invitations are on the way! Thanks for sharing the love."
    redirect_to '/dashboard'
  end
    
  
end