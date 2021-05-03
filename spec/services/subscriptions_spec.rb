require 'rails_helper'

RSpec.describe SubscriptionsService do
  let!(:user)     { create(:user) }
  let!(:question) { create(:question) }
  let!(:answer)   { create(:answer, question: question) }

  before { question.subscribers << user }

  it 'sends new answer information to subscribed user' do
    question.subscribers.each do |subscriber|
      expect(SubscriptionsMailer).to receive(:send_notification).with(subscriber, answer).and_call_original
    end
    subject.send_subscriptions(answer)
  end
end
