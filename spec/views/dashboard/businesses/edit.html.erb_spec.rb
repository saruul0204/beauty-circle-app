# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/businesses/edit.html.erb' do # rubocop:disable RSpec/DescribeClass
  it 'displays business form' do
    assign(:business, Business.new)

    render partial: 'business_form'

    expect(rendered).to include('General Information', 'Location', 'Hours', 'Contact and socials', 'Submit')
  end
end
