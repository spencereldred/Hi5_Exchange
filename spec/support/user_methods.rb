def signup(email, password)
  visit new_user_session_path
  click_link "Sign up"
  expect(page).to have_content("Password confirmation")
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
  click_button "Sign up"
end

def login(email, password)
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Login"
end

def delete_user(email)
  User.find_by(email: email).delete
end