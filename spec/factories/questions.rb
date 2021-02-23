FactoryBot.define do
  sequence :title do |n|
    "QuestionTitle#{n}"
  end

  sequence :body do |n|
    "QuestionBody#{n}"
  end

  factory :question do
    title
    body
    user

    trait :invalid do
      title { nil }
    end

    factory :question_with_answers do
      transient do
        answers_count {5}
      end
    end
  end
end
