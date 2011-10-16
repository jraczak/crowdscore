require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_numericality_of(:zip_code) }
  it { should allow_value("80202").for(:zip_code) }
  it { should allow_value("802.2").for(:zip_code) }
  it { should_not allow_value("180202").for(:zip_code) }
  it { should_not allow_value("8020").for(:zip_code) }

  context "with a saved user" do
    subject { Factory(:user) }

    # This test requires a user to already exist
    it { should validate_uniqueness_of(:username) }
  end

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:username) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:zip_code) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
  it { should allow_mass_assignment_of(:birth_month) }
  it { should allow_mass_assignment_of(:birth_day) }
  it { should_not allow_mass_assignment_of(:locked_at) }
  it { should_not allow_mass_assignment_of(:admin) }

  it { should allow_mass_assignment_of(:email).as(:admin) }
  it { should allow_mass_assignment_of(:username) }
  it { should allow_mass_assignment_of(:first_name).as(:admin) }
  it { should allow_mass_assignment_of(:last_name).as(:admin) }
  it { should allow_mass_assignment_of(:zip_code).as(:admin) }
  it { should allow_mass_assignment_of(:password).as(:admin) }
  it { should allow_mass_assignment_of(:password_confirmation).as(:admin) }
  it { should allow_mass_assignment_of(:remember_me).as(:admin) }
  it { should allow_mass_assignment_of(:birth_month).as(:admin) }
  it { should allow_mass_assignment_of(:birth_day).as(:admin) }
  it { should allow_mass_assignment_of(:admin).as(:admin) }

  it { should_not be_admin }

  context "with first and last name" do
    subject { Factory.build(:user, first_name: "Bobby", last_name: "Barker") }
    its(:full_name) { should == 'Bobby Barker' }
  end

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

  describe "username" do
    subject { Factory.create(:user, username: "jimbob") }
    before { subject.username = "jim"; subject.valid? }

    its("errors.full_messages.to_sentence") { should == "Username cannot be changed" }
  end

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

  describe "a user can be locked with a reason" do
    before { subject.lock_with_reason!(message) }

    context "when message is not empty" do
      let(:message) { "um...." }
      its(:access_locked?) { should be_true }
      its(:lock_reason) { should == message }
    end

    context "when the message is empty" do
      let(:message) { "" }
      its(:access_locked?) { should be_false }
      it { should_not be_valid }
      its("errors.full_messages") { should include("Lock reason can't be blank") }
    end
  end

  context "unlocking a locked user" do
    subject { Factory.create(:locked_user) }

    before { subject.unlock_access! }

    its(:lock_reason) { should be_blank }
    its(:locked_at) { should be_blank }
    its(:access_locked?) { should_not be }
  end
end
