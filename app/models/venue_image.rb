class VenueImage < ActiveRecord::Base
  belongs_to :venue

  mount_uploader :image_file, AttachmentUploader

  validates :venue, :image_file, presence: true
end
