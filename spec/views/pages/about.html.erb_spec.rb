# frozen_string_literal: true

require 'rails_helper'

describe 'pages/about.html.erb' do # rubocop:disable RSpec/DescribeClass
  it 'renders about page' do
    render

    expect(rendered).to include('About Beauty Circle', 'Join Us')
  end
end
