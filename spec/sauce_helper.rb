# You should edit this file with the browsers you wish to use
# For options, check out http://saucelabs.com/docs/platforms
require "sauce"
require "sauce/capybara"

Sauce.config do |config|
  config[:browsers] = [
    ["Windows 8", "Internet Explorer", "10"],
    ["Windows 8", "Chrome", "34"],
    ["Windows 8", "Firefox", "28"],
    ["Windows 8.1", "Internet Explorer", "11"],
    ["Windows 8.1", "Chrome", "34"],
    ["Windows 8.1", "Firefox", "28"],
    ["OS X 10.8", "Safari", "6"],
    ["OS X 10.8", "Chrome", "34"],
    ["OS X 10.9", "Safari", "7"],
    ["OS X 10.9", "Chrome", "34"],
    ["OS X 10.9", "Firefox", "28"]
  ]
  #config[:start_tunnel] = false
end
