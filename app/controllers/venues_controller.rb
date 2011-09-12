class VenuesController < InheritedResources::Base
  actions :index, :show, :new, :create
  before_filter :authenticate_user!, :except => [:index, :show]
end
