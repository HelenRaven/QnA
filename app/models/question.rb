class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one  :award, dependent: :destroy
  belongs_to :best_answer, class_name: 'Answer', optional: true
  belongs_to :user
  has_and_belongs_to_many :subscribers, class_name: 'User', dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :award, reject_if: :all_blank, allow_destroy: true

  has_many_attached :files

  validates :title, :body, presence: true

  after_commit :subscribe_author, on: :create

  def other_answers
    answers.where.not(id: best_answer_id)
  end

  private

  def subscribe_author
    subscribers << user
  end
end
