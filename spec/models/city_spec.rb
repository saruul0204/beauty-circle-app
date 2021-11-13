# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  subject(:city) { create(:city) }

  describe 'associations' do
    it { is_expected.to have_many(:businesses) }
  end
end