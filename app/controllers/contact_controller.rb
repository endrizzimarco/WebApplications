class ContactController < ApplicationController
  def contact
  end

  def request_contact
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    unless email.blank?
      redirect_back fallback_location:'/', notice: 'Email sent succesfully!'
    else 
      redirect_back fallback_location:'/', alert: 'Please insert an email'
    end

  end
end
