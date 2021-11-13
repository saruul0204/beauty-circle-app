# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Treatment, type: :model do
  subject(:treatment) { create(:treatment) }

  describe 'associations' do
    it { is_expected.to belong_to(:business) }
  end

  describe 'validations' do
    it { expect(treatment).to be_valid }

    %i[name description price duration].each do |field_name|
      it { expect(treatment).to validate_presence_of(field_name) }
    end
  end
end
