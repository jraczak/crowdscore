class UsersController < InheritedResources::Base
  actions :show
  custom_actions member: [:follow]

  before_filter :authenticate_user!, only: [:follow]

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
end
