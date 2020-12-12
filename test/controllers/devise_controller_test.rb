require 'test_helper'

class DeviseControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
  end

  test "should get log in page" do
    get new_user_session_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    assert_select 'img', count: 1 # Logo
    assert_select 'h2', 'Please log in'
    assert_select 'form', count: 2 # Log in + search bar
    assert_select 'label', 'Remember me'
    assert_select 'input[data-disable-with=?]', 'Log in' # Button
    assert_select 'a', 'Sign up' 
    assert_select 'a', 'Forgot your password?'
  end

  test "should get sign in page" do
    get new_user_registration_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    assert_select 'img', count: 1 # Logo
    assert_select 'h2', 'Please sign up'
    assert_select 'form', count: 2 # Sign in + search bar
    assert_select 'em', "6\ncharacters minimum"
    assert_select 'input[data-disable-with=?]', 'Sign up' # Button
    assert_select 'a', 'Log in'
  end

  test "should get edit user page" do
    # Need to be logged in to access this page
    get new_user_session_url
    sign_in @user
    post user_session_url

    get edit_user_registration_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    assert_select 'h2', 'Edit User'
    assert_select 'form', count: 3 # Edit + delete account + search bar
    assert_select 'input.form-control', count: 5 # 4 from edit + 1 from search bar
    assert_select 'div.pull-left', "Leave blank if you don't want to change it"
    assert_select 'input[data-disable-with=?]', 'Update' # Button
    assert_select 'h3', 'Unhappy?'
    assert_select 'input[data-confirm=?]', 'Are you sure?' # Delete button
    assert_select 'a', 'Back'
  end

  test "should get forgot password page" do
    get new_user_password_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    assert_select 'img', count:1 # Logo
    assert_select 'h2', 'Forgot your password?'
    assert_select 'form', count: 2 # Forgot pw + search bar
    assert_select 'input.form-control', count: 2 
    assert_select 'input[value=?]', 'Send me reset instructions' # Button
    assert_select 'a', 'Log in'
    assert_select 'a', 'Sign up'
  end

  test "should destroy user" do
    # Need to be logged in to access this page
    get new_user_session_url
    sign_in @user
    post user_session_url

    assert_difference('User.count', -1) do
      delete user_registration_url
    end
    assert_redirected_to root_url
  end

  test "should update user" do
    # Need to be logged in to access this page
    get new_user_session_url
    sign_in @user
    post user_session_url

    patch user_registration_url, params: { email: 'new@email' } 
    assert_response :success
  end
end