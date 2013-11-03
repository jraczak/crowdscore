#class User::ParameterSanitizer < Devise::ParameterSanitizer
    
private

  def sign_up
    default_params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :username)
  end
  
  def account_update
    default_params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :username)
  end

end