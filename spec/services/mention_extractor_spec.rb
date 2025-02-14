require 'rails_helper'

RSpec.describe MentionExtractor, type: :service do
  describe '.extract' do
    it 'returns users for mentioned usernames in the content' do
      user1 = create(:user, username: 'user1')
      user2 = create(:user, username: 'user2')

      content = "This is a comment mentioning @user1 and @user2."
      mentioned_users = MentionExtractor.extract(content)
      expect(mentioned_users).to include(user1, user2)
    end

    it 'returns an empty array if no mentions are found' do
      content = "This comment doesn't mention anyone."
      mentioned_users = MentionExtractor.extract(content)
      expect(mentioned_users).to be_empty
    end
  end
end
