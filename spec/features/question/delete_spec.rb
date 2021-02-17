require 'rails_helper'

feature 'Author can delete his question', %q{
  In order to delete question
  As an authenticated user and question author
  I'd like to be able to delete my question
} do

  given(:question) { create(:question) }

  scenario 'Authenticated author try to delete his question' do
      sign_in(question.user)
      visit question_path(question)
      click_on 'Delete question'

      expect(page).to have_content 'Your question was successfully deleted.'
  end
end
