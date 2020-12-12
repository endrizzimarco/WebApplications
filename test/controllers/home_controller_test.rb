require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do 
    get root_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'

    assert_select 'form', count: 2 # 2 search bars in home page
    assert_select 'div#title', 'Welcome to MyMovieList'
    assert_select 'h3 a', 'Sign up'
    assert_select 'h3', "Sign up\nto start adding movies to your seen and favourite lists"
  end

  test "should get contact" do
    get contact_url
    assert_response :success

    assert_template partial: '_header'
    assert_template partial: '_footer'
    assert_template layout: 'application'

    assert_select 'form', count: 2 # Contact form + header search bar
    assert_select 'h2', 'Contact Us'
    assert_select 'div.form-group', count: 5 # 4 inputs for form + header search bar
    assert_select 'input[value=?]', 'Submit' # Button
  end

  test "should post request contact but no mail" do
    post request_contact_url

    assert_response :redirect
    assert_not_empty flash[:alert]
    assert_nil flash[:notice]
  end

  test "should post request contact" do 
    post request_contact_url, params: {name: 'Real Person', email: 'real@mail.com', telephone: '1234567890', message: 'When is evangelion 3.0+1.0 coming out?'}
    assert_response :redirect
    assert_nil flash[:alert]
    assert_not_empty flash[:notice]
  end
end