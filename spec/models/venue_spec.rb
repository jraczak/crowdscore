require 'spec_helper'

describe Venue do
  it { should belong_to(:venue_category) }
  it { should belong_to(:venue_subcategory) }

  it { should have_many(:venue_images) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address1) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:venue_category) }
end
