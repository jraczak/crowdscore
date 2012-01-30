require 'spec_helper'

describe List do
  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:venues) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
end
