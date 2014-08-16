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
