require 'watir'
require 'webdrivers'
require 'json'

# Get test data from json file
file = File.open('test-data.json')
file_data = file.read
data = JSON.parse(file_data)
file.close

# Initalize the Browser (Chrome by default)
browser = Watir::Browser.new

# Navigate to LinkedIn Home Page
browser.goto 'https://www.linkedin.com'

# Navigate to the Form and Sign in
login_link = browser.link(css: '[data-tracking-control-name="guest_homepage-basic_nav-header-signin"]')
login_link.click
login_link.wait_until(&:stale?) # because login form is a bit flaky

browser.text_field(id: 'username').set data['email']
browser.text_field(id: 'password').set data['pwd']
browser.button(css: '[data-litms-control-urn="login-submit"]').click


# Search for the person
search_field = browser.text_field(css: '[placeholder="Search"]')
search_field.set data['searchData']['name']
search_field.send_keys :enter

# Find the person we want to message
profile_results = browser.divs(css: '[data-test-search-result="PROFILE"]')
profile_results.first.wait_until(&:present?)
wanted_person = ''

## Go through results until we find the correct person
profile_results.each do |profile_result|
  search_result = profile_result.span(class: ['name','actor-name']).text
  if search_result == data['searchData']['fullName']
    wanted_person = profile_result
    break
  else
    raise 'Oopps! Wanted person not found!'
  end
end

# Message the wanted person
wanted_person.button(class: 'message-anywhere-button').click
msg_to_header = browser.section(class: 'msg-connections-typeahead__top-fixed-section')
msg_to_person = msg_to_header.span(class: 'artdeco-pill__text').text

## make sure it's the right person we're messaging to
if msg_to_person == data['searchData']['fullName']
  msg_text_box = browser.div(class: 'msg-form__contenteditable')
  msg_text_box.send_keys 'This is not the automation you\'re looking for... '
  send_button = browser.button(css: '[data-control-name="send"]')
  send_button.click
else
  raise 'Oopps! Almost messaged a wrong person.'
end

browser.close
