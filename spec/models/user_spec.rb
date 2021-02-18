require 'rails_helper'

RSpec.describe User, type: :model do
  let(:answer)   { create(:answer) }
  let(:question) { create(:question) }
  let(:user)     { create(:user) }

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  describe '.author?' do
    context 'true if author of object' do
      it { expect(question.user.author?(question)).to be true }
      it { expect(answer.user.author?(answer)).to be true }
    end

    context 'false if not author of object' do
      it { expect(user.author?(question)).to be false }
      it { expect(user.author?(answer)).to be false }
    end
  end
end
