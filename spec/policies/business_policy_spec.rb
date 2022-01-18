# frozen_string_literal: true

require 'rails_helper'

describe BusinessPolicy do
  subject(:business_policy) { described_class }

  context 'when a visitor' do
    let(:user) { nil }
    let(:business) { create :business }

    permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it 'does not grant access for not logged in visitors' do
        expect(business_policy).not_to permit(user, business)
      end
    end
  end

  context "when user is viewing other user's businesses or creating a business" do
    let(:business) { create :business }
    let(:user) { create :user }

    permissions :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it 'denies access to user for whom the business does not belong' do
        expect(business_policy).not_to permit(user, business)
      end
    end
  end
  # rubocop:disable Layout/LineLength

  context 'when user is editing own business' do
    link_to_default_image = Rails.root.join('spec/fixtures/files/salon_photo.jpg')
    let(:user) { create :user }

    permissions :edit?, :update?, :destroy? do
      it 'grants access if business belongs to user' do
        expect(business_policy).to permit(user, Business.create!(user_id: user.id, name: 'Some name', description: 'Some text',
                                                                 address: 'Some address', city_id: create(:city).id, country: 'MK',
                                                                 open_hour: '8am', close_hour: '8pm', phone_number: '123456',
                                                                 email: '123@test.com', images: [Rack::Test::UploadedFile.new(link_to_default_image, 'image/jpeg')]))
      end
    end
  end
end
# rubocop:enable Layout/LineLength
