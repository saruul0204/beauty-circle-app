# frozen_string_literal: true

require 'rails_helper'

describe Admin::BusinessesController, type: :controller do # rubocop:disable Metrics/BlockLength
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:new_business) { create :business }
  let(:admin_user) { create :admin_user }
  let(:valid_attributes) do
    attributes_for(:business).merge(user_id: new_business.user_id, city_id: new_business.city_id)
  end
  let(:invalid_attributes) { { user_id: '' } }

  before { sign_in admin_user }

  describe 'GET index' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:filters_sidebar) { page.find('#filters_sidebar_section') }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the business' do
      get :index
      expect(assigns(:businesses)).to include(new_business)
    end

    it 'renders the expected columns' do # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
      get :index
      expect(page).to have_content('Name')
      expect(page).to have_content('Description')
      expect(page).to have_content('Address')
      expect(page).to have_content('Country')
      expect(page).to have_content('Open Hour')
      expect(page).to have_content('Close Hour')
      expect(page).to have_content('Phone Number')
      expect(page).to have_content('Email')
      expect(page).to have_content('Facebook Url')
      expect(page).to have_content('Instagram Url')
      expect(page).to have_content('City')
    end

    it 'filter Name exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_user_id"]')
      expect(filters_sidebar).to have_css('input[name="q[description_contains]"]')
    end

    it 'filter Name works' do
      matching_business = create :business, name: 'ABCDEF'
      non_matching_business = create :business, name: 'GH'

      get :index, params: { q: { name_or_description_cont: 'BCDE' } }

      expect(assigns(:businesses)).to include(matching_business)
      expect(assigns(:businesses)).not_to include(non_matching_business)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns the business' do
      get :new
      expect(assigns(:business)).to be_a_new(Business)
    end

    it 'renders the form elements' do # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
      get :new
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_content('Address')
      expect(page).to have_content('Country')
      expect(page).to have_content('Open hour')
      expect(page).to have_content('Close hour')
      expect(page).to have_content('Phone number')
      expect(page).to have_content('Email')
      expect(page).to have_content('Facebook url')
      expect(page).to have_content('Instagram url')
      expect(page).to have_field('City')
      expect(page).to have_field('User')
    end
  end

  describe 'business create' do
    context 'with valid params' do
      it 'creates a new business' do
        expect do
          post :create, params: { business: valid_attributes }
        end.to change(Business, :count).by(1)
      end

      it 'assigns a newly created business as @business' do
        post :create, params: { business: valid_attributes }
        expect(assigns(:business)).to be_a(Business)
        expect(assigns(:business)).to be_persisted
      end

      it 'redirects to the created business' do
        post :create, params: { business: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_business_path(Business.last))
      end

      it 'creates the business' do
        post :create, params: { business: valid_attributes }
        last_business = Business.last

        expect(last_business.name).to eq(valid_attributes[:name])
        expect(last_business.description).to eq(valid_attributes[:description])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { business: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved business as @business' do
        post :create, params: { business: invalid_attributes }
        expect(assigns(:business)).to be_a_new(Business)
      end

      it 'invalid_attributes do not create a business' do
        expect do
          post :create, params: { business: invalid_attributes }
        end.not_to change(Business, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: new_business }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the business' do
      expect(assigns(:business)).to eq(new_business)
    end

    it 'renders the form elements' do # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
      expect(page).to have_field('User', with: new_business.user.id)
      expect(page).to have_field('Name', with: new_business.name)
      expect(page).to have_field('City', with: new_business.city.id)
      expect(page).to have_field('Description', with: new_business.description)
      expect(page).to have_field('Address', with: new_business.address)
      expect(page).to have_field('Country', with: new_business.country)
      expect(page).to have_field('Email', with: new_business.email)
      expect(page).to have_field('Phone number', with: new_business.phone_number)
      expect(page).to have_field('Open hour', with: new_business.open_hour)
      expect(page).to have_field('Close hour', with: new_business.close_hour)
      expect(page).to have_field('Facebook url', with: new_business.facebook_url)
      expect(page).to have_field('Instagram url', with: new_business.instagram_url)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: new_business.id, business: valid_attributes }
      end

      it 'assigns the business' do
        expect(assigns(:business)).to eq(new_business)
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_business_path(new_business))
      end

      it 'updates the business' do
        expect(new_business.reload.user_id).to eq(valid_attributes[:user_id])
        expect(new_business.city_id).to eq(valid_attributes[:city_id])
        expect(new_business.name).to eq(valid_attributes[:name])
        expect(new_business.description).to eq(valid_attributes[:description])
      end
    end

    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: new_business.id, business: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'does not change business' do
        expect do
          put :update, params: { id: new_business.id, business: invalid_attributes }
        end.not_to(change { new_business.reload.name })
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: new_business.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the business' do
      expect(assigns(:business)).to eq(new_business)
    end

    it 'renders the form elements' do
      expect(page).to have_content(new_business.name)
      expect(page).to have_content(new_business.description)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: new_business.id }
      end.to change(Business, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: new_business.id }
      expect(response).to redirect_to(admin_businesses_path)
    end
  end
end
