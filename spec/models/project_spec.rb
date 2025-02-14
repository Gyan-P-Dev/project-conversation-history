require 'rails_helper'

RSpec.describe Project, type: :model do
    
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }

  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:notifications).dependent(:destroy) }

  it "should define status as enum with the correct values" do
    expect(Project.statuses).to eq({ "open" => 0, "closed" => 1, "archived" => 2 })
  end

  describe "default status" do
    let(:project) { Project.new }

    it "should set status to 'open' by default" do
      expect(project.status).to eq("open")
    end
  end

  describe "after_initialize callback" do
    context "when a new project is created" do
      it "sets the default status to 'open'" do
        project = Project.new
        expect(project.status).to eq("open")
      end
    end

    context "when an existing project is updated" do
      it "does not change the status" do
        project = create(:project, status: :closed)
        project.update(name: "Updated Project")
        expect(project.status).to eq("closed")
      end
    end
  end

  describe "ransackable attributes" do
    it "should include the correct attributes" do
      expect(Project.ransackable_attributes).to include("id", "name", "status", "user_id", "created_at", "updated_at")
    end
  end
end
