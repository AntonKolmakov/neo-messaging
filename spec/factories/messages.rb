FactoryBot.define do
  factory :message do
    body { 'Thanks for your order. I will in touch shortly after reviewing your treatment application.' }
    outbox
    inbox

    trait :expired_message do
      created_at { 8.day.ago }
    end
  end
end