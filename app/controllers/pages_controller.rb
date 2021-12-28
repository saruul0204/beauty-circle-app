# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @cities = City.all
  end

  def about; end

  def contact
    @contact = Contact.new
  end

  def create_contact
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to pages_contact_path, notice: 'Thank you for contacting us.'

    else
      render :contact
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:full_name, :email, :message)
  end

  def city_params
    params.require(:city).permit(:name, :city_image)
  end
end
