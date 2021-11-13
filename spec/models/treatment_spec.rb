# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Treatment, type: :model do
  subject(:treatment) { create(:treatment) }

  describe 'associations' do
    it { is_expected.to belong_to(:business) }
  end
end
