class Crowdscore.Models.TipCollection extends Backbone.Collection
  url: -> "/venues/#{@venue_id}/tips"
  model: Crowdscore.Models.Tip
  comparator: (tip) => @sortRecent(tip)

  initialize: (models, options) ->
    console.log("ERROR: Must be initialized with a venue_id") unless options && options.venue_id
    @venue_id = options.venue_id

  enableSortRecent: =>
    @comparator = @sortRecent
    @sort()

  enableSortPopularity: =>
    @comparator = @sortPopularity
    @sort()

  sortRecent: (tip) =>
    # "Reverse" the string in a crafty way sort JS' sort functionality will
    # work in reverse.
    String.fromCharCode.apply String,
      _.map tip.get('created_at').split(""), (c) ->
          0xffff - c.charCodeAt()

  sortPopularity: (tip) =>
    - tip.get('tip_likes_count')
