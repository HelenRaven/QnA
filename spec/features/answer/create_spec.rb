require 'rails_helper'

feature 'User can create answer', %q{
  In order to help another user and community
  As an User
  I'd like to be able to post an answer to a question
} do

  given(:question) { create(:question) }

  background { visit question_path(question)}

  scenario 'User post an answer' do
    fill_in 'Body', with: 'some answer'

    click_on 'Post answer'
    expect(page).to have_content 'Your answer successfully created.'
  end

  scenario 'User post an answer with errors' do
    click_on 'Post answer'
    expect(page).to have_content "Answer can't be blank."
  end
end
