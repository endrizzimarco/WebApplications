class ApplicationMailer < ActionMailer::Base
  default to: 'info@mymovielist.com', from: 'some@guy.com'
  layout 'mailer'
end
