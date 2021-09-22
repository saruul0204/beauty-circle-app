# frozen_string_literal: true

require 'rails_helper'

describe 'pages/home.html.erb' do # rubocop:disable RSpec/DescribeClass
  it 'renders home page' do
    render

    expect(rendered).to include('Welcome to Beauty Circle')
  end
end
