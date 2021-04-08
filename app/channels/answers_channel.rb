class AnswersChannel < ApplicationCable::Channel
  def follow(id)
    stream_from "answers"
  end
end
