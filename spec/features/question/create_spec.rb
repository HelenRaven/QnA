require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from a community
  As an User
  I'd like to be able to ask the question
} do

  given!(:questions) { create_list(:question, 5) }

  background do
    visit questions_path
    click_on 'Ask question'
  end

  scenario 'User asks a question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    click_on 'Ask'

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text text text'
  end

  scenario 'User asks a question with errors' do
    click_on 'Ask'
    expect(page).to have_content "Title can't be blank"
  end
end
