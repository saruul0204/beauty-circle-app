# frozen_string_literal: true

require 'rails_helper'

describe Admin::TreatmentsController, type: :controller do # rubocop:disable Metrics/BlockLength
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:new_treatment) { create :treatment }
  let(:admin_user) { create :admin_user }
  let(:valid_attributes) do
    attributes_for(:treatment).merge(business_id: new_treatment.business_id)
  end
  let(:invalid_attributes) { { business_id: '' } }

  before { sign_in admin_user }

  describe 'GET index' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:filters_sidebar) { page.find('#filters_sidebar_section') }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the treatment' do
      get :index
      expect(assigns(:treatments)).to include(new_treatment)
    end

    it 'renders the expected columns' do
      get :index
      expect(page).to have_content('Name')
      expect(page).to have_content('Description')
      expect(page).to have_content('Price')
      expect(page).to have_content('Duration')
    end

    it 'filter Name exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_business_id"]')
      expect(filters_sidebar).to have_css('input[name="q[description_contains]"]')
    end

    it 'filter Name works' do
      matching_treatment = create :treatment, name: 'ABCDEF'
      non_matching_treatment = create :treatment, name: 'GH'

      get :index, params: { q: { name_or_description_cont: 'BCDE' } }

      expect(assigns(:treatments)).to include(matching_treatment)
      expect(assigns(:treatments)).not_to include(non_matching_treatment)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns the treatment' do
      get :new
      expect(assigns(:treatment)).to be_a_new(Treatment)
    end

    it 'renders the form elements' do # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
      get :new
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Price')
      expect(page).to have_field('Duration')
      expect(page).to have_field('Business')
    end
  end

  describe 'treatment create' do
    context 'with valid params' do
      it 'creates a new Treatment' do
        expect do
          post :create, params: { treatment: valid_attributes }
        end.to change(Treatment, :count).by(1)
      end

      it 'assigns a newly created treatment as @treatment' do
        post :create, params: { treatment: valid_attributes }
        expect(assigns(:treatment)).to be_a(Treatment)
        expect(assigns(:treatment)).to be_persisted
      end

      it 'redirects to the created treatment' do
        post :create, params: { treatment: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_treatment_path(Treatment.last))
      end

      it 'creates the treatment' do
        post :create, params: { treatment: valid_attributes }
        last_treatment = Treatment.last

        expect(last_treatment.name).to eq(valid_attributes[:name])
        expect(last_treatment.description).to eq(valid_attributes[:description])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { treatment: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved treatment as @treatment' do
        post :create, params: { treatment: invalid_attributes }
        expect(assigns(:treatment)).to be_a_new(Treatment)
      end

      it 'invalid_attributes do not create a treatment' do
        expect do
          post :create, params: { treatment: invalid_attributes }
        end.not_to change(Treatment, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: new_treatment }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the treatment' do
      expect(assigns(:treatment)).to eq(new_treatment)
    end

    it 'renders the form elements' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_field('Business', with: new_treatment.business.id)
      expect(page).to have_field('Name', with: new_treatment.name)
      expect(page).to have_field('Description', with: new_treatment.description)
      expect(page).to have_field('Price', with: new_treatment.price)
      expect(page).to have_field('Duration', with: new_treatment.duration)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: new_treatment.id, treatment: valid_attributes }
      end

      it 'assigns the treatment' do
        expect(assigns(:treatment)).to eq(new_treatment)
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_treatment_path(new_treatment))
      end

      it 'updates the treatment' do # rubocop:disable RSpec/MultipleExpectations
        expect(new_treatment.reload.business_id).to eq(valid_attributes[:business_id])
        expect(new_treatment.name).to eq(valid_attributes[:name])
        expect(new_treatment.description).to eq(valid_attributes[:description])
        expect(new_treatment.price).to eq(valid_attributes[:price])
        expect(new_treatment.duration).to eq(valid_attributes[:duration])
      end
    end

    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: new_treatment.id, treatment: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'does not change treatment' do
        expect do
          put :update, params: { id: new_treatment.id, treatment: invalid_attributes }
        end.not_to(change { new_treatment.reload.name })
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: new_treatment.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the treatment' do
      expect(assigns(:treatment)).to eq(new_treatment)
    end

    it 'renders the form elements' do
      expect(page).to have_content(new_treatment.name)
      expect(page).to have_content(new_treatment.description)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: new_treatment.id }
      end.to change(Treatment, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: new_treatment.id }
      expect(response).to redirect_to(admin_treatments_path)
    end
  end
end
