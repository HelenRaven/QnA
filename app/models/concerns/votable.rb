module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def rating
    vote_count(1) - vote_count(-1)
  end

  def vote(user, vote_value)
    if user.voted?(self)
      votes.where(user_id: user.id).delete_all
    elsif !user.author?(self)
      votes.create(user_id: user.id, value: vote_value)
    end
  end

  private

  def vote_count(vote_value)
    votes.where(value: vote_value).count
  end
end
