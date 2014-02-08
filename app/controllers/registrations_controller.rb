class RegistrationsController < Devise::RegistrationsController
  
  def update
    @user = User.find(current_user.id)
    
    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:user])
    else
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
    end
    
    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end
  
  def after_sign_up_path_for(devise_resource)
    edit_user_registration_path
  end
  
  #def account_update_params
  #  devise_parameter_sanitizer.for(:account_update)
  #end
  
  def after_update_path_for(resource)
    dashboard_path
  end
  
  private
  
  def needs_password?(user, params)
    params[:user][:password].present?
  end

end