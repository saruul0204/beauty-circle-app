# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }

  describe 'GET /businesses' do
    context 'with all businesses' do
      it 'has a success status code' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'with businesses with city param' do
      it 'has a success status code' do
        get :index, params: { salon_city: business.city }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with businesses with search param' do
      it 'has a success status code' do
        get :index, params: { search: { name: business.name, city_name: business.city.name } }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET show' do
    pending 'return http success' do
      get :show, params: { id: business.id }
      expect(response).to have_http_status(:success)
    end
  end
end
