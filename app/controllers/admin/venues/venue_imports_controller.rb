class Admin::Venues::VenueImportsController < InheritedResources::Base
  before_filter :authorize_admin!
  actions :new, :create

  def create
    create! do |success, failure|
      success.html do
        flash[:notice] = resource.report
        render :new
      end

      failure.html do
        flash[:error] = resource.errors.full_messages.to_sentence
        render :new
      end
    end
  end
end
