require 'spec_helper'

describe Tip do
  subject { Factory.build(:tip) }

  it { should validate_presence_of(:venue) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:text) }

  it { should allow_value("t").for(:text) }
  it { should allow_value("t" * 100).for(:text) }
  it { should_not allow_value("t" * 101).for(:text) }
end
