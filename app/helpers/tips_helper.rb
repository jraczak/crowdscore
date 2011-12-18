module TipsHelper
  def upvote_link_for(tip)
    return '' if !user_signed_in? || tip.user == current_user

    if !current_user.liked_tips.include?(tip)
      " ".html_safe + link_to('upvote', upvote_venue_tip_path(tip.venue, tip))
    else
      ''
    end
  end
end
