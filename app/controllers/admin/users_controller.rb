class Admin::UsersController < InheritedResources::Base
  before_filter :authorize_admin!
  before_filter :remove_blank_password_field, :only => :update

  with_role :admin

  def create
    build_resource
    resource.confirmed_at = Time.now
    create!
  end
  
  def show
    @user = User.find_by_permalink(params[:id])
  end
  
  def edit
    @user = User.find_by_permalink(params[:id])
  end
  
  def collection
    @users ||= end_of_association_chain.page(params[:page])
  end

  private

  def remove_blank_password_field
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end
