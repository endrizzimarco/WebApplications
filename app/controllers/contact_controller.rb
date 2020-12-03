class ContactController < ApplicationController
  def contact
  end

  def request_contact
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    unless email.blank?
      redirect_back fallback_location:'/', notice: I18n.t('contact.request_contact.notice')
    else 
      redirect_back fallback_location:'/', alert: I18n.t('contact.request_contact.alert') 
    end

  end
end
