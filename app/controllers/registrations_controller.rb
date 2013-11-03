class RegistrationsController < Devise::RegistrationsController
  
  def after_sign_up_path_for(devise_resource)
    edit_user_registration_path
  end
  
  #def account_update_params
  #  devise_parameter_sanitizer.for(:account_update)
  #end

end