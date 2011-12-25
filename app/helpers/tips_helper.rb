module TipsHelper
  def upvote_link_for(tip)
    return '' unless tip.can_upvote(current_user)

    " ".html_safe + link_to('upvote', upvote_venue_tip_path(tip.venue, tip))
  end

  def prepare_tips_for_js_init(resource)
    tips = resource.tips.by_recent

    tips.each do |t|
      t.current_user_id = current_user.try(:id)
    end

    raw tips.to_json
    end
end
