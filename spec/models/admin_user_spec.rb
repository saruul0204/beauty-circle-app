# frozen_string_literal: true

require 'rails_helper'

describe AdminUser, type: :model do
  subject(:admin_user) { create :admin_user }

  describe 'validations' do
    it { expect(admin_user).to be_valid }
  end
end
