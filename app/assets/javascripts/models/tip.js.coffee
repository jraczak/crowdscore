class window.Tip extends Backbone.Model
  upvoteUrl: ->
    "#{@url()}/upvote"

  domId: ->
    "tip_#{@id}"
