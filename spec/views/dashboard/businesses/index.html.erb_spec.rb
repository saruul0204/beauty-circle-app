# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'businesses/index.html.erb', type: :view do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }

  before do
    assign(:businesses, [business])
  end

  context 'with dynamic content' do
    it 'displays a business card' do
      render

      expect(rendered).to include(business.name, business.city, business.phone_number, business.description,
                                  'See more information', 'Edit')
    end
  end
end
