FactoryBot.define do
  factory :user do
    after :create do |user|
      create :outbox, user: user 
      create :inbox, user: user 
    end

    trait :patient do
      is_patient { true }
      first_name { 'Luke' }
      last_name { 'Skywalker' }
    end

    trait :doctor do
      is_patient { false }
      is_doctor { true }
      first_name { 'Leia' }
      last_name { 'Organa' }
    end

    trait :admin do
      is_patient { false }
      is_admin { true }
      first_name { 'Obi-wan' }
      last_name { 'Kenobi' }
    end
  end
end