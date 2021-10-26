# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'businesses/show.html.erb', type: :view do
  let(:business) { create(:business) }

  it 'displays a business card' do
    assign(:business, business)

    render

    expect(rendered).to include(business.name, business.country, business.city, business.address, business.open_hour,
                                 business.close_hour, business.phone_number, business.description, business.email)
    end
  end
