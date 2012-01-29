class ListsController < InheritedResources::Base
  before_filter :authenticate_user!

  private
  
  def begin_of_association_chain
    current_user
  end
end
