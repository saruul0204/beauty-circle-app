# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Business, type: :model do
  subject(:business) { create(:business) }

  describe 'validations' do
    it { expect(business).to be_valid }

    %i[name description address city country open_hour close_hour phone_number email ].each do |field_name|
      it { expect(business).to validate_presence_of(field_name) }
    end
  end
end
