require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
  it { should allow_mass_assignment_of(:birth_month) }
  it { should allow_mass_assignment_of(:birth_day) }

  ::Date::MONTHNAMES.each do |month|
    it { should allow_value(month).for(:birth_month) }
  end

  it { should allow_value("").for(:birth_month) }
  it { should_not allow_value("Saturday").for(:birth_month) }

  (1..31).to_a.each do |day|
    it { should allow_value(day).for(:birth_day) }
  end

  (1..31).to_a.map(&:to_s).each do |day|
    it { should allow_value(day).for(:birth_day) }
  end

  it { should allow_value("").for(:birth_day) }
  it { should_not allow_value("32").for(:birth_day) }

  describe "date checking" do
    context "when month is set" do
      subject { Factory.build(:user, :birth_month => "July") }
      it { should_not allow_value("").for(:birth_day) }
    end

    context "when month and day form a real date" do
      subject { Factory.build(:user, birth_month: "February", birth_day: day) }

      context "when day is an integer" do
        let(:day) { 5 }
        it { should be_valid }
      end

      context "when day is a string" do
        let(:day) { "5" }
        it { should be_valid }
      end
    end

    context "when month and day form a non-real date" do
      subject { Factory.build(:user, birth_month: "February", birth_day: 30) }
      it do
        should_not be_valid
        subject.errors.full_messages.first.should == "Birthday should be a real day of the year."
      end
    end

    context "when day is set" do
      subject { Factory.build(:user, :birth_day => 30) }
      it { should_not allow_value("").for(:birth_month) }
    end
  end
end
