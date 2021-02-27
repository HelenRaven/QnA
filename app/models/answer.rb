class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def mark_as_best()
    question.best_answer = self
    question.save
  end
end
