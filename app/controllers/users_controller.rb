class UsersController < InheritedResources::Base
  actions :show
  custom_actions member: [:follow]

  before_filter :authenticate_user!, only: [:follow]

  def show
    #@user = User.find_by_permalink(params[:id])
    @user = User.find_by_permalink(params[:username])
  end
  
  def follow
    if current_user == resource
      flash[:notice] = "You can't follow yourself."
    elsif current_user.follows?(resource)
      flash[:notice] = "You are already following that user!"
    else
      current_user.follows << resource
      flash[:notice] = "You are now following #{resource.username}"
    end

    redirect_to resource
  end
  
  def unfollow
    Follow.where(followed_id: resource.id, follower_id: current_user.id).first.delete
    #resource.follows.where(follower_id = current_user.id)
    flash[:notice] = "You are no longer following #{resource.username}"
    redirect_to resource
  end
end
