# frozen_string_literal: true

require 'rails_helper'

describe Dashboard::BusinessesController, type: :controller do
  let!(:user) { create :user }

  before { sign_in user }

  describe 'GET dashboard/businesses' do
    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET dashboard/businesses/:id' do
    let(:business) { create(:business, user: user) }

    it 'has a 200 status code' do
      get :show, params: { id: business.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET dashboard/business' do
    it 'has a 200 status code' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  # rubocop:disable Layout/LineLength

  describe 'POST create business' do
    context 'with valid attributes' do
      it 'creates new business' do
        expect do
          post :create,
               params: { business: { name: 'Some name', description: 'Some text', address: 'Some address', city_id: create(:city).id, country: 'MK',
                                     open_hour: '8am', close_hour: '8pm', phone_number: '123456', email: '123@test.com' } }
        end.to change(Business, :count).by(1)
      end
    end
    # rubocop:enable Layout/LineLength

    context 'with invalid attributes' do
      it 'doesnt create new business' do
        expect do
          post :create,
               params: { business: { name: '', description: '' } }
        end.to change(Business, :count).by(0)
      end
    end
  end

  describe 'GET dashboard/businesses/:id/edit' do
    let(:business) { create(:business, user: user) }

    it 'has a 200 status code' do
      get :edit, params: { id: business.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH business' do
    let(:business) { create(:business, user: user) }

    context 'with valid attributes' do
      it 'updates business' do
        patch :update,
              params: { id: business.id, business: { name: 'Another name', description: 'Another text' } }
        allow(business).to receive(:name).and_return('Another name')
        allow(business).to receive(:description).and_return('Some text')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the business' do
        patch :update,
              params: { id: business.id, business: { name: '', description: '' } }
        expect(response).not_to be_redirect
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:business) { create(:business, user: user) }

    it 'deletes a business' do
      expect do
        delete :destroy, params: { id: business.id }
      end.to change(Business, :count).by(-1)
    end
  end
end
