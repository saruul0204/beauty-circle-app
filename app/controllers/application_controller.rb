# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_locale
  before_action { @pagy_locale = params[:locale] }

  def default_url_options
    { locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
