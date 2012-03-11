require 'spec_helper'

describe Tag do
  it { should belong_to(:tag_category) }
  it { should have_and_belong_to_many(:venues) }

  it { should validate_presence_of(:tag_category) }
  it { should validate_presence_of(:name) }

  it "has a full name" do
    category = mock(TagCategory, name: "serves")
    tag = Factory.build(:tag, name: "brunch")
    tag.stub(:tag_category) { category }

    tag.full_name.should == "serves brunch"
  end
end
