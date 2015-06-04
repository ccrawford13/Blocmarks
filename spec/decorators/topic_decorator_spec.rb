require 'rails_helper'

RSpec.describe TopicDecorator, type: :decorator do

  let(:topic) { create(:topic, user: user).decorate }
  let(:user) { build(:user, first_name: 'Jon', last_name: 'Doe') }

  it 'returns formatted creation date' do
    expect(topic.creation_date).to eq(topic.created_at.strftime("%a %b %d, %I:%M%p"))
  end

  describe '#author_name' do

    it "returns full name as string" do
      expect(topic.author_name).to eq 'Jon Doe'
    end

    it 'returns titleized full_name' do
      user.update_attributes(first_name: 'jon', last_name: 'williams')
      expect(topic.author_name).to eq 'Jon Williams'
    end
  end

  describe '#bookmark_count' do

    it 'returns Topic bookamrk count' do
      expect(topic.bookmark_count).to eq topic.bookmarks.count
    end
  end

  describe '#author_information' do
    # Need to find cleaner way to test this - other than testing that the method == itself
    it 'returns author info string' do
      test_message = "Created by: #{topic.author_name} on #{topic.creation_date}"
      expect(topic.author_information).to eq test_message
    end
  end

  describe '#topic_link' do
    # Need to find cleaner way to test this - other than testing that the method == itself
    it 'returns link to topic' do
      test_link = h.link_to "#{topic.title.titleize}", h.topic_path(topic)
      expect(topic.topic_link).to eq test_link
    end
  end
end
