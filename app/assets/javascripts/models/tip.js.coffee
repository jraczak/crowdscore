class window.Tip extends Backbone.Model
  upvoteUrl: ->
    "#{@url()}/upvote"

  domId: ->
    "tip_#{@id}"

  upvoteCountText: ->
    count = @get('tip_likes_count')
    if count == 1
      " (1 vote)"
    else
      " (#{count} votes)"
