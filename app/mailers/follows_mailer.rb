class FollowsMailer < ActionMailer::Base
  default from: "\"Crowdscore Support\" <support@crowdsco.re>"
  
  def new_follower_email(followed, follower)
    @follower = follower
    @followed = followed
    mail(to: followed.email, subject: "You have a new follower on Crowdscore!")
  end
  
end
