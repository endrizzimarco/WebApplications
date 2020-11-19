class ApplicationMailer < ActionMailer::Base
  default to: 'info@mymovielist.com', from: 'info@mymovielist.com'
  layout 'mailer'
end
