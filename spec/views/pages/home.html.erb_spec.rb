# frozen_string_literal: true

require 'rails_helper'

describe 'pages/home.html.erb' do # rubocop:disable RSpec/DescribeClass
  let(:city) { create(:city) }

  it 'renders home page' do
    assign(:cities, [city])

    render

    expect(rendered).to include('Discover & book local')
  end
end
