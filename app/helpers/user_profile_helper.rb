module UserProfileHelper


def highest_score_class(user)
  if user.highest_score.class == String
    "no-score-text"
  else
    "score-number"
  end
end

def average_score_class(user)
  if user.average_score.class == String
    "no-score-text"
  else
    "score-number"
  end
end

def lowest_score_class(user)
  if user.lowest_score.class == String
    "no-score-text"
  else
    "score-number"
  end
end

def user_full_location(user)
  if user.home_city.present? && user.home_state.present?
    "#{user.home_city.titleize}, #{user.home_state.capitalize}"
  elsif user.home_state.present? && user.home_city.blank?
    "#{user.home_state.capitalize}"
  elsif user.home_city.present? && user.home_state.blank?
    "#{user.home_city.titleize}"
  end
end

def no_location(user)
  user.home_city.blank? && user.home_state.blank?
end

end