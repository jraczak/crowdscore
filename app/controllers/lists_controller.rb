class ListsController < InheritedResources::Base
  include JobScheduler
  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, only: [:show]
  custom_actions resource: [:add, :remove, :upvote, :remove_vote]
   
  respond_to :html, :json
   
  def new
    @list = List.new
  end
   
  def create
    @list = List.new(params[:list])
    @list.user_id = current_user.id
      
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: "Your list '#{@list.name}' was created." }
        format.json { render json: @list, status: :created, location: @list }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
    #publish_facebook_list_creation(@list)
    if current_user.facebook_id && current_user.facebook_access_token
      Delayed::Job.enqueue JobScheduler::PublishFBListCreation.new(list_url(@list), current_user.facebook_access_token), 0, 1.minutes.from_now
    end
  end
   
  def add
    venue = Venue.find(params[:venue_id])
    unless resource.venues.include?(venue)
      resource.venues << venue
    end
   
    respond_to do |format|
      format.json { render json: {notice: "Successfully added #{venue.name} to #{resource.name}", status: :ok} }
    end
  end
   
  def remove
    venue = Venue.find(params[:venue_id])
    resource.venues.delete(venue)
   
    render nothing: true, status: :ok
  end
     
  def show
    @json = resource.venues.to_gmaps4rails
  end
  
  def upvote
    unless current_user.liked_lists.include?(resource)
    current_user.liked_lists << resource
    #current_user.save!
    publish_facebook_list_favorite(resource)
    end
    
    respond_to do |format|
      format.html { redirect_to resource }
      format.js { render "upvote", :locals => {:list => resource} }
    end
  end
   
  def remove_vote
    current_user.liked_lists.delete(resource)
    #current_user.save!
    List.decrement_counter(:list_likes_count, resource.id)
    
    respond_to do |format|
      format.html { redirect_to resource }
      format.js { render "remove_vote", :locals => {:list => resource} }
    end
  end
  
  def publish_facebook_list_favorite(list)
    @app = FbGraph::Application.new(ENV['FACEBOOK_APP_ID'], :secret => ENV['FACEBOOK_APP_SECRET'])
    @fb_user = FbGraph::User.me(current_user.facebook_access_token)
      
    unless Rails.env.development?
      action = @fb_user.og_action!(
               @app.og_action(:favorite), :list => list_url(list))
    end
  end
  
  #def publish_facebook_list_creation(list)
  #  @app = FbGraph::Application.new(ENV['FACEBOOK_APP_ID'], :secret => ENV['FACEBOOK_APP_SECRET'])
  #  @fb_user = FbGraph::User.me(current_user.facebook_access_token)
  #  
  #  action = @fb_user.og_action!(
  #           @app.og_action(:create), :list => list_url(list))
  #end
  #handle_asynchronously :publish_facebook_list_creation, :run_at => Proc.new { 1.minutes.from_now }
   
  protected
    def resource
      @list = List.find(params[:id])
    end
   
  private
   
  def begin_of_association_chain
    current_user
  end
end