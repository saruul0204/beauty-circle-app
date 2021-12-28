# frozen_string_literal: true

require 'rails_helper'

describe Admin::CitiesController, type: :controller do # rubocop:disable Metrics/BlockLength
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:city) { create :city }
  let(:valid_attributes) do
    attributes_for(:city).merge(name: city.name)
  end
  let(:invalid_attributes) do
    { name: '' }
  end

  before { sign_in create(:admin_user) }

  describe 'GET index' do
    let(:filters_sidebar) { page.find('#filters_sidebar_section') }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the city' do
      get :index
      expect(assigns(:cities)).to include(city)
    end

    it 'renders the expected columns' do
      get :index
      expect(page).to have_content(city.name)
    end

    it 'filter Name exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_name"]')
      expect(filters_sidebar).to have_css('input[name="q[name_contains]"]')
    end

    it 'filter Name works' do
      matching_city = create :city, name: 'Struga'
      non_matching_city = create :city, name: 'Bitola'

      get :index, params: { q: { name_cont: 'struga' } }

      expect(assigns(:cities)).to include(matching_city)
      expect(assigns(:cities)).not_to include(non_matching_city)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns the city' do
      get :new
      expect(assigns(:city)).to be_a_new(City)
    end

    it 'renders the form elements' do
      get :new
      expect(page).to have_field('Name')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new city' do
        expect do
          post :create, params: { city: valid_attributes }
        end.to change(City, :count).by(1)
      end

      it 'assigns a newly created city as @city' do
        post :create, params: { city: valid_attributes }
        expect(assigns(:city)).to be_a(City)
        expect(assigns(:city)).to be_persisted
      end

      it 'redirects to the created city' do
        post :create, params: { city: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to(redirect_to(admin_city_path(City.last)))
      end

      it 'creates the city' do
        post :create, params: { city: valid_attributes }
        city = City.last
        expect(city.name).to eq(valid_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { city: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved city as @city' do
        post :create, params: { city: invalid_attributes }
        expect(assigns(:city)).to be_a_new(City)
      end

      it 'invalid_attributes do not create a city' do
        expect do
          post :create, params: { city: invalid_attributes }
        end.not_to change(City, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: city.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the city' do
      expect(assigns(:city)).to eq(city)
    end

    it 'renders the form elements' do
      expect(page).to have_field('Name', with: city.name)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: city.id, user: valid_attributes }
      end

      it 'assigns the city' do
        expect(assigns(:city)).to eq(city)
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_city_path(city))
      end

      it 'updates the city' do
        city.reload

        expect(city.name).to eq(valid_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: city.id, city: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'does not change city' do
        expect do
          put :update, params: { id: city.id, city: invalid_attributes }
        end.not_to(change { city.reload.name })
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: city.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the user' do
      expect(assigns(:city)).to eq(city)
    end

    it 'renders the form elements' do
      expect(page).to have_content(city.name)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: city.id }
      end.to change(City, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: city.id }
      expect(response).to redirect_to(admin_cities_path)
    end
  end
end
