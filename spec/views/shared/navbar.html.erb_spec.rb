# frozen_string_literal: true

require 'rails_helper'

describe 'shared/navbar' do # rubocop:disable RSpec/DescribeClass
  it 'displays navbar links' do
    assign(I18n.available_locales, [])

    render partial: 'shared/navbar'

    expect(rendered).to include('Browse salons', 'About', 'Contact us', 'Sign in', 'Sign up')
  end
end
