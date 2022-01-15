# frozen_string_literal: true

  ActionMailer::Base.smtp_settings = {
    user_name: "apikey",
    password: ENV['BEAUTY_CIRCLE_SENDGRID'],
    domain: ENV['BEAUTY_CIRCLE_DOMAIN'],
    address: "smtp.sendgrid.net",
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }