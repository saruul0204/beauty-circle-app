# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/businesses/new.html.erb' do # rubocop:disable RSpec/DescribeClass
  before do
    assign(:business, Business.new)
    assign(:treatment, business.treatments.new)

  end

  it 'displays business form' do
    assign(:business, Business.new)

    render partial: 'form'

    expect(rendered).to include('General Information', 'Location', 'Hours', 'Contact and socials', 'Submit')
  end

  it 'displays treatment form' do
    render partial: 'treatments/treatment_fields', locals: { form: treatment }

    expect(rendered).to include('Name', 'Description', 'Duration', 'Price')
  end
end
