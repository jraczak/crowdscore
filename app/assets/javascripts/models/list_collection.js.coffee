class window.ListCollection extends Backbone.Collection
  url: "/lists.json"
  model: List
  comparator: (list) => list.get('name').toLowerCase()
