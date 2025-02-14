class Notification < ApplicationRecord
  belongs_to :comment
  belongs_to :user
  belongs_to :project

  after_create :send_notification

  private

  def send_notification
    NotificationMailer.mention_email(user, comment).deliver_now
  end
end
