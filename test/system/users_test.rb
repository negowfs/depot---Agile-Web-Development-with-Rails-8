require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    login_as @user
  end

  test "visiting the index" do
    visit users_path
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    unique = Time.now.to_i
    name = "user_#{unique}"
    email = "user_#{unique}@example.com"

    visit users_path
    click_on "New user"

    fill_in "Email address", with: email
    fill_in "Name", with: name
    fill_in "user_password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    click_on "Create User"

    assert_text "User #{name} was successfully created."
  end

  test "should update User" do
    visit user_path(@user)
    click_on "Edit this user", match: :first

    fill_in "Email address", with: @user.email_address
    fill_in "Name", with: @user.name
    fill_in "user_password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    click_on "Update User"

    assert_text "User #{@user.name} was successfully updated."
  end

  test "should destroy User" do
    visit user_path(@user)
    accept_confirm { click_on "Destroy this user", match: :first }

    assert_text "User was successfully destroyed"
  end
end
