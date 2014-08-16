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
