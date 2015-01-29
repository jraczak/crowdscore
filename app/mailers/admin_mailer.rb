class AdminMailer < ActionMailer::Base
  default from: "\"Crowdscore Admins\" <justin@crowdsco.re>"
  
  def new_user_email(user)
    @user = user
    mail(to: ["justin@crowdsco.re", "criskedmenec@gmail.com", "mamariljr@gmail.com"], subject: "New Crowdscore user")
  end
  
  def onboarding_completed_email(user)
    @user = user
    mail(to: ["justin@crowdsco.re", "criskedmenec@gmail.com", "mamariljr@gmail.com"], subject: "User has completed onboarding")
  end
  
end
