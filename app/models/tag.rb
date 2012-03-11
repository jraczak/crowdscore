class Tag < ActiveRecord::Base
  belongs_to :tag_category
  has_and_belongs_to_many :venues, uniq: true

  validates :name, :tag_category, presence: true

  def full_name
    "#{tag_category.name} #{name}"
  end

  def as_json(options = {})
    super({include: {tag_category: {only: [:name, :id]}}, only: [:name, :id]}.merge(options))
  end
end
