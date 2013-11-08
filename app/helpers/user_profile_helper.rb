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


end