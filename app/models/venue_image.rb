class VenueImage < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user

  # mount_uploader :image_file, AttachmentUploader

  validates :venue, :image_file, :user, presence: true
end
