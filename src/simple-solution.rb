require 'watir'
require 'webdrivers'
require 'json'

# Get test data from json file
file = File.open('test-data.json')
file_data = file.read
data = JSON.parse(file_data)
file.close

# # Initalize the Browser (Chrome by default)
browser = Watir::Browser.new

# # Navigate to LinkedIn Home Page
browser.goto 'https://www.linkedin.com'

# # Authenticate and Navigate to the Form
browser.link(css: '[data-tracking-control-name="guest_homepage-basic_nav-header-signin"]').click
browser.text_field(id: 'username').set data['username']
browser.text_field(id: 'password').set data['pwd']
browser.button(css: '[data-litms-control-urn="login-submit"]').click