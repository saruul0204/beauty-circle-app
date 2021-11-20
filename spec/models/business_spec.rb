# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Business, type: :model do
  subject(:business) { create(:business, user: user) }

  let(:user) { create :user }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:treatments) }
    it { is_expected.to belong_to(:city) }
  end

  describe 'validations' do
    it { expect(business).to be_valid }

    %i[name description address country open_hour close_hour phone_number email].each do |field_name|
      it { expect(business).to validate_presence_of(field_name) }
    end
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:treatments) }
  end

  describe 'method full_address' do
    let(:new_city) { create(:city, name: 'Struga') }
    let(:business) { create :business, address: '1st street', city: new_city, user: user, country: 'Macedonia' }

    it 'creates full address' do
      expect(business.full_address).to eq('1st street, Struga, Macedonia')
    end
  end
end
