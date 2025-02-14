require 'rails_helper'

RSpec.describe Mention, type: :model do
  let(:user) { create(:user, email: "user@example.com", username: "testuser") }
  let(:comment) { create(:comment, user: user, content: "Test comment") }
  
  it { should belong_to(:user) }
  it { should belong_to(:comment) }
  

  it "can be created with a valid comment and user" do
    mention = Mention.create(comment: comment, user: user)
    expect(mention).to be_valid
  end

  it "is invalid without a comment" do
    mention = Mention.new(user: user)
    expect(mention).not_to be_valid
  end

  it "is invalid without a user" do
    mention = Mention.new(comment: comment)
    expect(mention).not_to be_valid
  end
end
