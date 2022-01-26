# frozen_string_literal: true

require 'rails_helper'

describe DashboardPolicy do
  subject(:dashboard_policy) { described_class }

  context 'when a visitor' do
    let(:user) { nil }
    # let(:business) { create :business }

    permissions :home? do
      it 'does not grant access for not logged in visitors' do
        expect(dashboard_policy).not_to permit(user)
      end
    end
  end

  context 'when user is accessing dashboard' do
    let(:user) { create :user }
    # let(:business) { create(:business, user: user) }

    permissions :home? do
      it 'grants access to user' do
        expect(dashboard_policy).to permit(user)
      end
    end
  end
end
