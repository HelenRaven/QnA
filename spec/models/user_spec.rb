require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:question) { create(:question) }
  let(:user)      { create(:user) }

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:awards) }
  it { should have_many(:authorizations).dependent(:destroy) }

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    let(:service) { double('Services::FindForOauth') }

    it 'calls Services::FindForOauth' do
      expect(FindForOauthService).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end

  describe '#author?' do
    context 'true if author of object' do
      it { expect(question.user).to be_author(question) }
    end

    context 'false if not author of object' do
      it { expect(user).to_not be_author(question) }
    end
  end
end
