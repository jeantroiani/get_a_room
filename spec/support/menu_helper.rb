def login_as(email, password)
	visit ('/users/sign_in')
	fill_in 'user_login', with: email
	fill_in 'user_password', with: password
	click_button 'Log in'
end