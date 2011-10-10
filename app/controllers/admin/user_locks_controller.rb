class Admin::UserLocksController < InheritedResources::Base
  before_filter :authorize_admin!
  actions :new, :create
  defaults resource_class: User, instance_name: 'user_to_lock'

  def create
    user = build_resource
    user.lock_with_reason!(params[:user][:lock_reason])
    respond_with user, location: admin_user_path(user)
  end

  private

  def build_resource
    @user_to_lock ||= User.find(params[:user_id])
  end

end
