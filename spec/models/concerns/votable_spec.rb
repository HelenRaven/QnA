require 'rails_helper'

describe 'votable' do
  with_model :WithVotable do
    table do |t|
      t.bigint :user_id
    end

    model do
      include Votable
    end
  end

  let(:users)  { create_list(:user, 3) }
  let(:object) { WithVotable.create! }

  it '#rating' do
    expect(WithVotable.new.rating).to eq 0
  end

  it '#vote' do
    users.each do |user|
      object.vote(user, 1)
    end
    expect(object.rating).to eq users.count

    object.vote(users.first, 0)
    expect(object.rating).to eq users.count - 1

    object.vote(users.first, -1)
    expect(object.rating).to eq users.count - 2
  end
end
