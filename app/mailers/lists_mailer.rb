class ListsMailer < ActionMailer::Base
  
  default from: "\"Crowdscore\" <support@crowdsco.re>"

  def list_like_email(list, owner, liker)
    @owner = owner
    @liker = liker
    @list = list
    mail(to: owner.email, subject: "#{liker.username} liked your list #{list.name} on Crowdscore")
  end

end