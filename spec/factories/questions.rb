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
    best_answer { nil }

    trait :invalid do
      title { nil }
    end

    trait :with_best_answer do
      best_answer factory: :answer
    end

    after(:create) do |question|
      question.files.attach(io: File.open(Rails.root.join("spec","files","star.jpg")),filename: 'star.jpg', content_type: 'image/jpeg')
    end

    factory :question_with_answers do
      transient do
        answers_count { 5 }
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question)
      end
    end
  end
end
