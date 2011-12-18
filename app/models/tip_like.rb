class TipLike < ActiveRecord::Base
  belongs_to :tip, counter_cache: true
  belongs_to :user
end
