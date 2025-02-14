class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :project
  belongs_to :user
  
  has_many :mentions, dependent: :destroy
  has_many :mentioned_users, through: :mentions, source: :user
  has_many :notifications, dependent: :destroy

  after_create :extract_mentions

  scope :ordered_comments, -> { order(created_at: :desc) }

  private

  def extract_mentions
    mentioned_users = MentionExtractor.extract(content)
    mentioned_users.each do |user|
      mentions.create(user: user)
      Notification.create(user: user, comment: self, project: project)
    end
  end
end
