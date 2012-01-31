class window.ListCollection extends Backbone.Collection
  url: "/lists"
  model: List
  comparator: (list) => list.get('name').toLowerCase()
