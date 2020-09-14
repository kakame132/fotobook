require 'rails_helper'

RSpec.describe "SignUps", type: :system do

before do
driven_by :selenium, using: :chrome
end

it "should show error messages when user not filling the form" do
visit '/users/sign_up'
click_button "Sign up"

expect(page).to have_text("Please enter")
end

it "should go to guest page when user signing up successfully" do
visit '/users/sign_up'

fill_in "user[first_name]", :with => "Anthony"
fill_in "user[last_name]", :with => "Hollywood"
fill_in "user[email]", :with => "pppp@yopmail.com"
fill_in "user[password]", :with => "123456789"
fill_in "user[password_confirmation]", :with => "123456789"

click_button "Sign up"

expect(page.current_path).to eq user_registration_path
end
end
