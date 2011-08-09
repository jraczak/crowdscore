require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
end
