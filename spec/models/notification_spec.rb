require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create(:user, email: "user@example.com", username: "testuser") }
  let(:project) { create(:project, user: user, name: "Test Project") }
  let(:comment) { create(:comment, user: user, project: project, content: "Test comment") }
  
  it { should belong_to(:user) }
  it { should belong_to(:comment) }
  it { should belong_to(:project) }

  describe "callbacks" do
    it "calls send_notification after create" do
      expect(NotificationMailer).to receive(:mention_email).with(user, comment).and_call_original
      notification = Notification.create(user: user, comment: comment, project: project)
    end
  end

  describe "send_notification" do
    let(:mailer) { double("NotificationMailer") }

    it "sends the mention email" do
      allow(NotificationMailer).to receive(:mention_email).and_return(mailer)
      allow(mailer).to receive(:deliver_now)

      notification = Notification.create(user: user, comment: comment, project: project)
      expect(NotificationMailer).to have_received(:mention_email).with(user, comment)
      expect(mailer).to have_received(:deliver_now)
    end
  end
end
