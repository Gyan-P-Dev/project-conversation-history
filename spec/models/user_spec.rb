require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:projects).dependent(:destroy) }
  it { should have_many(:notifications).dependent(:destroy) }
  it { should have_many(:mentions).dependent(:destroy) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  it { should validate_presence_of(:email) }

  it { should validate_length_of(:password).is_at_least(6) }

  describe "ransackable_attributes" do
    it "should include id, email, name, created_at, updated_at" do
      expect(User.ransackable_attributes).to include('id', 'email', 'name', 'created_at', 'updated_at')
    end
  end
end
