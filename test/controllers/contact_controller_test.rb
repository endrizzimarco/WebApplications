require 'test_helper'

class ContactControllerTest < ActionDispatch::IntegrationTest

  test "should get contact" do
    get contact_url
    assert_response :success
  
    assert_template layout: 'application'

    assert_select 'title', 'MyMovieList'
    assert_select 'h2', 'Contact Us'
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