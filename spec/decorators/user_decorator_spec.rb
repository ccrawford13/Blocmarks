require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do

  describe '#full_name' do

    it "returns full name as string" do
      user = build(:user, first_name: 'Jon', last_name: 'Doe').decorate
      expect(user.full_name).to eq 'Jon Doe'
    end

    it 'returns titliezed full_name' do
      user = build(:user, first_name: 'jon', last_name: 'doe').decorate
      expect(user.full_name).to eq 'Jon Doe'
    end
  end

  context "count decorators" do

    let(:user) { build(:user).decorate }

    it '#like_count returns User like count' do
      expect(user.like_count).to eq user.likes.count
    end

    it '#topic_count returns User topic count' do
      expect(user.topic_count).to eq user.topics.count
    end

    it '#bookmark_count returns User bookmark count' do
      expect(user.bookmark_count).to eq user.topics.count
    end
  end
end
