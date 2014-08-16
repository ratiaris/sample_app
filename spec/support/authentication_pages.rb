def valid_signin(user, options = {})
	if options[:no_capybara]
		# Sign in when not using Capybara.
		remember_token = User.new_remember_token
		cookies[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
	else	
		signin(user.email, user.password)
	end
end

def invalid_signin
	email = "toto@tutu.com";
	signin(email, email)
end


def signin(email, password)
	visit signin_path
	fill_in "Email",    with: email
	fill_in "Password", with: password
	click_button "Sign in"
end
