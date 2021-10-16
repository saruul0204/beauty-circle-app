# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  subject(:user) { create :user }

  describe 'validations' do
    it { expect(user).to be_valid }

    %i[username first_name last_name email password].each do |field_name|
      it { expect(user).to validate_presence_of(field_name) }
    end
  end

  describe 'user registration fail cases' do
    %w[username first_name last_name email password].each do |field|
      context "with empty #{field}" do
        before { user.public_send("#{field}=", '') }

        it 'sets validation error' do
          expect(user.tap(&:valid?).errors.full_messages).to include("#{field.humanize} can't be blank").once
        end
      end
    end

    %w[username first_name last_name].each do |field|
      context "with small length of #{field}" do
        before { user.public_send("#{field}=", 'A') }

        it 'sets validation error' do
          expect(user.tap(&:valid?).errors.full_messages)
            .to include("#{field.humanize} is too short (minimum is #{::User::MIN_LEN} characters)").once
        end
      end

      context "with large length of #{field}" do
        before { user.public_send("#{field}=", 'A' * 251) }

        it 'sets validation error' do
          expect(user.tap(&:valid?).errors.full_messages)
            .to include("#{field.humanize} is too long (maximum is #{::User::MAX_LEN} characters)").once
        end
      end
    end

    %w[..].each do |invalid|
      context 'with invalid email prefix format' do
        before { user.email = "#{invalid}@yahoo.com" }

        it 'sets validation error' do
          expect(user.tap(&:valid?).errors.full_messages).to include('Email is invalid').once
        end
      end
    end

    context "when password confirmation doesn't match with password" do
      before { user.password_confirmation = '' }

      it 'sets validation error' do
        expect(user.tap(&:valid?).errors.full_messages).to include("Password confirmation doesn't match Password").once
      end
    end

    context 'with duplicated email' do
      let(:another_user) { build :user, email: user.email }

      it 'sets validation error' do
        expect(another_user.tap(&:valid?).errors.full_messages).to include('Email has already been taken').once
      end
    end

    context 'with duplicated username' do
      let(:another_user) { build :user, username: user.username.upcase }

      it 'sets validation error' do
        expect(another_user.tap(&:valid?).errors.full_messages).to include('Username has already been taken').once
      end
    end

    context 'with weak password' do
      before do
        user.password = '12345'
        user.password_confirmation = '12345'
      end

      it 'sets validation error' do
        expect(user.tap(&:valid?).errors.full_messages)
          .to include("Password is too short (minimum is #{Devise.password_length.min} characters)").once
      end
    end

    context 'with long password' do
      before do
        user.password = '1234567890' * 10
        user.password_confirmation = '1234567890' * 10
      end

      it 'sets validation error' do
        expect(user.tap(&:valid?).errors.full_messages)
          .not_to include("Password is too long (maximum is #{Devise.password_length.max} characters)")
      end
    end
  end
end
