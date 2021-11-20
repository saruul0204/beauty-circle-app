# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/businesses/edit.html.erb' do # rubocop:disable RSpec/DescribeClass
  before { assign(:business, Business.new) }

  it 'displays business form' do
    render partial: 'form'

    expect(rendered).to include('General Information', 'Location', 'Hours', 'Contact and socials', 'Submit')
  end

  it 'displays treatment form' do
    render partial: 'form'

    expect(rendered).to include('Name', 'Description', 'Duration', 'Price')
  end
end
