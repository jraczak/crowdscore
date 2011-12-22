class Crowdscore.Models.Tip extends Backbone.Model
  upvoteUrl: ->
    "#{@url()}/upvote"

  domId: ->
    "tip_#{@id}"
