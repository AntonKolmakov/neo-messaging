FactoryBot.define do
  factory :message do
    body { 'To doctor...' }
    inbox
    outbox

    trait :expired_message do
      body { 'This is expire message.' }
      created_at { 8.day.ago }
    end
  end
end