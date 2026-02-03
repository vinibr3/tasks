FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    date { Faker::Date.between(from: '2025-01-01', to: 1.year.from_now.strftime('%Y-%m-%d')) }
    task { nil }
  end
end
