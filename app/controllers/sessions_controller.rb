class SessionsController < Devise::SessionsController

def create
  tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_PROJECT_TOKEN'])
  super do |resource|
    tracker.track(resource.id, 'Signed In')
  end
end

end