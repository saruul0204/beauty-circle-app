# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }

  describe 'GET /businesses' do
    it 'has a success status code' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show' do
    it 'return http success' do
      get :show, params: { user_id: user.id, id: business.id }
      expect(response).to have_http_status(:success)
    end
  end
end
