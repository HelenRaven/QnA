require 'rails_helper'

feature 'User can view question with list of answers', %q{
  In order to view all answers for question
  As an User
  I'd like to be able to view list of answers
} do

  given(:answer) { create(:answer) }

  scenario 'User view question with list of answers' do
    visit question_path(answer.question)

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'MyAnswer'
  end
end
