FactoryBot.define do
  factory :user do
    trait :patient do
      is_patient { true }
      first_name { 'Luke' }
      last_name { 'Skywalker' }
      after(:build) do |user|
        FactoryBot.build(:inbox, user: user)
        FactoryBot.build(:outbox, user: user)
      end
    end

    trait :doctor do
      is_patient { false }
      is_doctor { true }
      first_name { 'Leia' }
      last_name { 'Organa' }
      after(:build) do |user|
        FactoryBot.build(:inbox, user: user)
        FactoryBot.build(:outbox, user: user)
      end
    end

    trait :admin do
      is_patient { false }
      is_admin { true }
      first_name { 'Obi-wan' }
      last_name { 'Kenobi' }
      after(:build) do |user|
        FactoryBot.build(:inbox, user: user)
        FactoryBot.build(:outbox, user: user)
      end
    end
  end
end