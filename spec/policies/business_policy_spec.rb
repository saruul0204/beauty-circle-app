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

  context 'when user is editing own business' do
    let(:user) { create :user }
    let(:business) { create(:business, user: user) }

    permissions :edit?, :update?, :destroy? do
      it 'grants access if business belongs to user' do
        expect(business_policy).to permit(user, business)
      end
    end
  end
end
