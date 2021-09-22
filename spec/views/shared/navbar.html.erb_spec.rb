# frozen_string_literal: true

require 'rails_helper'

describe 'shared/navbar' do # rubocop:disable RSpec/DescribeClass
  it 'displays navbar links' do
    render partial: 'shared/navbar'

    expect(rendered).to include('Browse salons', 'About', 'Contact us', 'Sign in', 'Sign up')
  end
end
