class RegistrationsController < Devise::RegistrationsController
  
  def create
    if User.find_by_email(params[:user][:email])
      @existing_user = User.find_by_email(params[:user][:email])
      if @existing_user.was_invited?
        redirect_to accept_user_invitation_path(:invitation_token => @existing_user.invitation_token)
        flash[:notice] = "It looks like you were invited by #{User.find(@existing_user.invited_by_id).first_name}. Fill out this quick form and you'll be good to go!"
      else
        redirect_to new_user_session_path
        flash[:notice] = "Looks like you've already got an account. Sign in below."
      end
    else
      super
    end
  end
  
  def after_sign_up_path_for(devise_resource)
    edit_user_registration_path
  end
  
  #def account_update_params
  #  devise_parameter_sanitizer.for(:account_update)
  #end

end