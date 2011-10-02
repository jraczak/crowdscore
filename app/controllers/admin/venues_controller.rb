class Admin::VenuesController < InheritedResources::Base
  before_filter :authorize_admin!
end
