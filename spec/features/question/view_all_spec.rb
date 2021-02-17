require 'rails_helper'

feature 'User can view list of questions', %q{
  In order to find a suitable question
  As an User
  I'd like to be able to view list of questions
} do

  given!(:questions) { create_list(:question, 5) }

  scenario 'User view all questions' do
    visit questions_path

    save_and_open_page
    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
  end

end
