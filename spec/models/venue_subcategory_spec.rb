require 'spec_helper'

describe VenueSubcategory do
  it { should belong_to :venue_category }
  it { should have_many :venues }

  it { should validate_presence_of :name }
  it { should validate_presence_of :venue_category }
end
