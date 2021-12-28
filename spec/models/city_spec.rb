# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  subject(:city) { create(:city) }

  describe 'associations' do
    it { is_expected.to have_many(:businesses) }
  end

  describe 'validate image' do
    it { expect(city.city_image.attached?).to eq(true) }
  end
end
