# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/businesses/new.html.erb' do # rubocop:disable RSpec/DescribeClass
  it 'displays business form' do
    assign(:business, Business.new)

    render partial: 'form'

    expect(rendered).to include('General Information', 'Location', 'Hours', 'Contact and socials', 'Submit')
  end
end
