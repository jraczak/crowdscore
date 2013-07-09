class VenueImagesController < InheritedResources::Base
  belongs_to :venue
  actions :new, :create

  before_filter :authenticate_user!

  def create
    build_resource.user = current_user

    s3 = AWS::S3.new
    bucket = s3.buckets["crowdscore-media-#{Rails.env}"]


    obj = bucket.objects.create(params[:venue_image][:image_file].original_filename, params[:venue_image][:image_file].read, :acl => :public_read)
    build_resource.image_file = "http://#{obj.bucket.name}.s3.amazonaws.com/#{obj.key}"

    create!
  end
end
