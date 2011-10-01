# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue_image do
    venue
    caption "My dinner!"
    image_file { File.open(Rails.root.join('spec', 'test_files', 'venue_image.jpg')) }
  end

  factory :venue_image_without_image_file, parent: :venue_image do
    image_file nil
  end
end
