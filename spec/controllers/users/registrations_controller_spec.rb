# frozen_string_literal: true

require 'rails_helper'

describe Users::RegistrationsController, type: :controller do
  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  it 'permits user params' do
    params = { user: { username: 'JohnDoe', first_name: 'John', last_name: 'Doe', email: 'johndoe@example.com',
                       password: 'password', password_confirmation: 'password' } }
    expect(User).to permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)
      .for(:create, params: params, verb: :post)
  end

  describe 'update user successfully' do
    let!(:user) { create(:user) }

    before { sign_in user }

    it 'updates user params' do
      params = attributes_for(:user, username: 'janelee', first_name: 'Jane', current_password: 'password')
      put :update, params: { user: params }
      user.reload
      expect(user.username).to eq('janelee')
      expect(user.first_name).to eq('Jane')
    end
  end

  describe 'soft delete for deleting a user' do
    let!(:user) { create(:user) }

    before { sign_in user }

    it 'doesn\'t delete the user from database' do
      expect do
        delete :destroy
      end.to change(User, :count).by(0)
    end
  end

  describe 'permanently deletes a user' do
    let!(:user) { create(:user) }

    before { sign_in user }

    it 'delete the user from database' do
      expect do
        delete :destroy
      end.to change(User.where(deleted_at: nil), :count).by(-1)
    end
  end
end
