# frozen_string_literal: true

require 'rails_helper'

describe 'shared/footer' do # rubocop:disable RSpec/DescribeClass
  it 'displays footer icons' do
    render partial: 'shared/footer'

    expect(rendered).to include('https://www.twitter.com/')
    expect(rendered).to include('https://www.instagram.com/')
    expect(rendered).to include('https://www.facebook.com/')
  end
end
