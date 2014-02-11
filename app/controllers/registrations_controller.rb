class RegistrationsController < Devise::RegistrationsController
  
  def create
    #Check to see if a user with provided email address exists
    if User.find_by_email(params[:user][:email])
      @existing_user = User.find_by_email(params[:user][:email])
      #Check to see if the user was created through Devise's invite
      if @existing_user.was_invited?
        #If the user was invited, redirect them to accept the invitation and pass the token
        redirect_to accept_user_invitation_path(:invitation_token => @existing_user.invitation_token)
        flash[:notice] = "It looks like you were invited by #{User.find(@existing_user.invited_by_id).first_name}. Fill out this quick form and you'll be good to go!"
      else
        #If the user exists but wasn't invited, remind them of their account and redirect to sign in
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