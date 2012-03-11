class window.Tag extends Backbone.Model
  category: -> @get('tag_category').name
  categoryId: -> @get('tag_category').id
