# frozen_string_literal: true

require 'rails_helper'

describe 'shared/navbar' do #rubocop:disable  RSpec/DescribeClass
  before do
    controller.request.path_parameters[:controller] = 'pages'
    controller.request.path_parameters[:action] = 'home'
  end

  it 'displays navbar links' do
    render partial: 'shared/navbar'

    expect(rendered).to include('Browse salons', 'About', 'Contact us', 'Sign in', 'Sign up')
    I18n.available_locales.each { |l| expect(rendered).to include(url_for(locale: l)) }
  end
end
