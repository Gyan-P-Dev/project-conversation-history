require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user, email: "user@example.com", username: "testuser") }
  let(:project) { create(:project, name: "Test Project", user: user) }
  let(:comment) { build(:comment, user: user, project: project) }

  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should have_many(:mentions).dependent(:destroy) }
  it { should have_many(:mentioned_users).through(:mentions).source(:user) }
  it { should have_many(:notifications).dependent(:destroy) }

  it { should validate_presence_of(:content) }

  describe "callbacks" do
    it "calls extract_mentions after creating a comment" do
      expect(comment).to receive(:extract_mentions)
      comment.save
    end
  end

  describe ".ordered_comments" do
    it "returns comments ordered by created_at in descending order" do
      comment1 = create(:comment, created_at: 1.day.ago, project: project)
      comment2 = create(:comment, created_at: 2.days.ago, project: project)
      comment3 = create(:comment, created_at: 3.days.ago, project: project)

      ordered_comments = Comment.ordered_comments
      expect(ordered_comments).to eq([comment1, comment2, comment3])
    end
  end
end
