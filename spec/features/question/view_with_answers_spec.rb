require 'rails_helper'

feature 'User can view question with list of answers', "
  In order to view all answers for question
  As an User
  I'd like to be able to view list of answers
" do
  given(:questions) { create_list(:question, 3) }
  given(:user) { create(:user) }

  scenario 'User view question with list of answers' do
    questions.each do |question|
      sign_in(user)

      3.times do |i|
        post_answer(question, "#{question.title}Answer#{i}")
      end

      sign_out

      visit question_path(question)

      expect(page).to have_content question.title
      expect(page).to have_content question.body
      3.times do |i|
        expect(page).to have_content "#{question.title}Answer#{i}"
      end
    end
  end
end
