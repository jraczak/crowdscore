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

  def create
    # Instantiate a Mixpanel tracker
    tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_PROJECT_TOKEN'])
    # Check to see if a user with provided email address exists
    if User.find_by_email(params[:user][:email])
      @existing_user = User.find_by_email(params[:user][:email])
      #Check to see if the user was created through Devise's invite
      if @existing_user.was_invited?
        # If the user was invited, redirect them to accept the invitation and pass the token
        redirect_to accept_user_invitation_path(:invitation_token => @existing_user.invitation_token)
        flash[:notice] = "It looks like you were invited by #{User.find(@existing_user.invited_by_id).first_name}. Fill out this quick form and you'll be good to go!"
      else
        # If the user exists but wasn't invited, remind them of their account and redirect to sign in
        redirect_to new_user_session_path
        flash[:notice] = "Looks like you've already got an account. Sign in below."
      end
    else
      super
      # create the user in Mixpanel
      if resource.save
        tracker.people.set("#{resource.id}", {
	        '$first_name' => resource.first_name,
	        '$email' => resource.email,
	        '$username' => resource.username
        })
        tracker.track(resource.id, 'Signed Up')
        
      # send a notification email to admins
        AdminMailer.new_user_email(resource).deliver
        redirect_to after_signup_path_for(resource)
      end
    end
  end
  
  def after_signup_path_for(devise_resource)
    #edit_user_registration_path
    dashboard_path
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