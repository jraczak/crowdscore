require 'spec_helper'

describe VenueCategory do
  it { should have_many(:venues) }

  it { should validate_presence_of(:name) }
end
