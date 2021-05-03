class SubscriptionsService
  def send_subscriptions(answer)
    users = answer.question.subscribers
    users.each do |user|
      SubscriptionsMailer.send_notification(user, answer).deliver_later
    end
  end
end
