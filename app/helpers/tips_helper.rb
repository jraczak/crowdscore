module TipsHelper
  def upvote_link_for(tip)
    return '' unless tip.can_upvote(current_user)

    " ".html_safe + link_to('upvote', upvote_venue_tip_path(tip.venue, tip))
  end
end
