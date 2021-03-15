require 'rails_helper'

shared_examples 'voted' do
  let!(:user)     { create(:user) }
  let!(:question) { create(:question) }
  let!(:voted)    { create(:vote, user: user, votable: question, value: 1) }

  before { login(user) }

  describe 'PATCH#vote_up' do
    it 'responds with success' do
      patch :vote_up, params: { id: question }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH#vote_down' do
    it 'responds with success' do
      patch :vote_down, params: { id: question }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH#vote_cancel' do
    it 'responds with success' do
      patch :vote_cancel, params: { id: question }, format: :json
      expect(response).to have_http_status(:success)
    end
  end
end

describe QuestionsController, type: :controller do
  it_behaves_like 'voted'
end
