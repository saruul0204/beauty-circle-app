# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'businesses/index.html.erb', type: :view do
  include Pagy::Backend
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }

  before do
    assign(:businesses, [business])
    assign(:pagy, pagy(Business.order(created_at: :desc)))
  end

  context 'with dynamic content' do
    it 'displays a business card' do
      pending 'Unresolved'
      render

      expect(rendered).to include(business.name, business.city, business.phone_number, business.description,
                                  'See more information')
    end
  end
end
