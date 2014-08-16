require 'rspec/expectations'

include ApplicationHelper

def valid_signin(user)
	signin(user.email, user.password)
end

def invalid_signin
	email = "toto@tutu.com";
	signin(email, email)
end


def signin(email, password)
	fill_in "Email",    with: email
	fill_in "Password", with: password
	click_button "Sign in"
end

def fill_in_invalid_signup_information
	fill_in_signup_information("A", "foo@bar.com", "f", "f")
end

def fill_in_valid_signup_information
	fill_in_signup_information("Example User", "user@example.com", "foobar", "foobar")
end

def fill_in_signup_information(name, email, password, password_confirmation)
	fill_in "Name", 		with: name
	fill_in "Email", 		with: email
	fill_in "Password",     with: password
	fill_in "Confirmation", with: password_confirmation
end

RSpec::Matchers.define :have_error_message do | message |
	match do | page |
		expect(page).to have_selector('div.alert.alert-danger', text: message)
	end
end

RSpec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end
