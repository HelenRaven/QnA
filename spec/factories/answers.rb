FactoryBot.define do
  sequence :answer_body do |n|
    "Answer#{n}"
  end

  factory :answer do
    body { :answer_body }
    question
    user

    trait :invalid do
      body { nil }
    end
  end
end
