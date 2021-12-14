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

    it { is_expected.to validate_attached_of(:images) }
    it { is_expected.to validate_content_type_of(:images).allowing('image/png', 'image/jpg', 'image/jpeg') }
    it { is_expected.to validate_content_type_of(:images).rejecting('text/plain', 'text/xml') }
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

  describe 'method search' do
    before { create(:treatment, business: business) }

    let!(:new_city) { create(:city, name: 'Struga') }
    let!(:business) { create :business, name: 'Test', city_id: new_city.id, user: user }
    let!(:business1) { create :business, name: 'Exx', city_id: new_city.id, user: user }

    it 'finds searched business by name' do
      results = described_class.search(name: 'test', city_name: 'struga')
      expect(results).to eq([business])
    end

    it 'doesnt find searched business by name' do
      results = described_class.search(name: 'exx', city_name: 'ohrid')
      expect(results).not_to eq([business1])
    end
  end

  describe 'scope active' do
    context 'when business is active' do
      let!(:business) { create :business, user: user }

      it 'can find the business' do
        expect(described_class.active).to eq([business])
      end
    end

    context 'when business is inactive' do
      let!(:business) { create :business, deleted_at: Time.zone.now, user: user }

      it 'cant find the business' do
        expect(described_class.active).not_to eq([business])
      end
    end
  end
end
