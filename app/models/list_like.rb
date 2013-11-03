class ListLike < ActiveRecord::Base
  belongs_to :list, counter_cache: true
  belongs_to :user
  

end
