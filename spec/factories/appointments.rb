# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    title { 'MyString' }
    client_name { 'MyString' }
    client_email { 'MyString' }
    start_time { '2023-02-02 01:55:09' }
    treatment { nil }
    user { nil }
  end
end
