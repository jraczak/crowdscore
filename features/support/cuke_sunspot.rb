# Taken from http://blog.kabisa.nl/2010/02/03/running-cucumber-features-with-sunspot_rails/
require "net/http"

class CukeSunspot

  def start
    @started = Time.now
    puts "Sunspot server is starting..."
    `bundle exec sunspot-solr start -p #{port}`
    up
  end

  def stop
    `bundle exec sunspot-solr stop`
  end

  private

  def port
    8981
  end

  def uri
    "http://0.0.0.0:#{port}/solr/"
  end

  def up
    puts "Sunspot server took #{'%.2f' % (Time.now - @started)} sec. to get up and running. Let's cuke!"
  end

end

