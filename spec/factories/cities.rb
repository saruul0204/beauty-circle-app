# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    name { %w[Skopje Ohrid Struga Bitola Stip Strumica Kumanovo Tetovo Gostivar].sample }
  end
end
