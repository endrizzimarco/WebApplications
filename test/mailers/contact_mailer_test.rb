require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  test "should return contact email" do
    mail = ContactMailer.contact_email('Real Person', 'real@mail.com', '1234567890', @message = 'When is evangelion 3.0+1.0 coming out?')
    assert_equal ['info@mymovielist.com'], mail.to
    assert_equal ['info@mymovielist.com'], mail.from
  end
end
