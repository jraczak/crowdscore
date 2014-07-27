module JobScheduler
  
  class FacebookListCreation < Struct.new(:list_url, :facebook_access_token)
    def perform
      @app = FbGraph::Application.new(ENV['FACEBOOK_APP_ID'], :secret => ENV['FACEBOOK_APP_SECRET'])
      @fb_user = FbGraph::User.me(facebook_access_token)
      
      action = @fb_user.og_action!(
               @app.og_action(:create), :list => list_url)
    end
  end
  
  class PublishFBListCreation < Struct.new(:full_list_url, :facebook_access_token)
    def perform
      @app = FbGraph::Application.new(ENV['FACEBOOK_APP_ID'], :secret => ENV['FACEBOOK_APP_SECRET'])
      @fb_user = FbGraph::User.me(facebook_access_token)
      
      puts "Attempting to publish action..."
      action = @fb_user.og_action!(
               @app.og_action(:create), :list => full_list_url)
      if action
        puts "Action should be published..."
      else
        puts "Action was not published..."
      end
    end
  end
  
  

end