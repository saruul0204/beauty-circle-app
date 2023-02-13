# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'businesses/show.html.erb', type: :view do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:treatment) { create(:treatment, business: business) }

  before do
    assign(:business, business)
    assign(:treatments, [treatment])
  end

  it 'displays a business card' do
    render

    expect(rendered).to include(business.name, business.country, business.city.name, business.address,
                                business.open_hour, business.close_hour, business.phone_number,
                                business.description, business.email)
  end

  it 'displays treatments' do
    render

    expect(rendered).to include(treatment.name, treatment.description, treatment.duration.to_s, treatment.price)
  end
end
