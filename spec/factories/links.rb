FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { 'http://google.com' }
    linkable factory: :question
  end
end
