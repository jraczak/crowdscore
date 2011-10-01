require 'spec_helper'

describe AttachmentUploader do
  include CarrierWave::Test::Matchers

  let(:venue_image) { Factory.build(:venue_image, :image_file => nil) }
  subject { AttachmentUploader.new(venue_image, :attachment) }

  before do
    AttachmentUploader.enable_processing = true
    subject.store!(File.open(Rails.root.join('spec', 'test_files', 'venue_image.jpg')))
  end

  after do
    AttachmentUploader.enable_processing = false
  end

  context 'the thumb version' do
    it "scales down the image to exactly 210x150" do
      # pending "Testing this does not seem to work when mocking Fog."
      subject.thumb.should have_dimensions(210, 150)
    end
  end
end
