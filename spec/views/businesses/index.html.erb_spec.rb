# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'businesses/index.html.erb', type: :view do
  include Pagy::Backend
  let!(:user) { create(:user) }
  let!(:business) { create(:business, user: user) }

  before do
    assign(:businesses, [business])
    assign(:pagy, pagy(Business.order(created_at: :desc)))
  end

  context 'with dynamic content' do
    pending 'displays a business card' do
      render

      expect(rendered).to include(business.name, business.city.name, business.phone_number, business.description,
                                  'See more information')
    end
  end
end
