require 'rails_helper'

feature 'Author can delete his answer', %q{
  In order to delete answer
  As an authenticated user and question author
  I'd like to be able to delete my answer
} do

  given(:answer) { create(:answer) }

  scenario 'Authenticated author try to delete his answer' do
      sign_in(answer.user)
      visit answer_path(answer)
      click_on 'Delete answer'

      expect(page).to have_content 'Your answer was successfully deleted.'
  end
end
