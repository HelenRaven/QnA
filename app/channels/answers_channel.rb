class AnswersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "answer_for_#{params[:question]}"
  end

  def unsubscribed
  end
end
