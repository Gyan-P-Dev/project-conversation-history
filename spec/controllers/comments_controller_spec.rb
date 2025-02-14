require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new comment and associates it with the project and user" do
        expect {
          post :create, params: { project_id: project.id, comment: { content: "This is a test comment." } }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the project page with a success message" do
        post :create, params: { project_id: project.id, comment: { content: "This is a test comment." } }
        expect(response).to redirect_to(project_path(project))
        expect(flash[:notice]).to eq("Comment added successfully.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new comment" do
        expect {
          post :create, params: { project_id: project.id, comment: { content: "" } }
        }.to_not change(Comment, :count)
      end

      it "redirects to the project page with an error message" do
        post :create, params: { project_id: project.id, comment: { content: "" } }
        expect(response).to redirect_to(project_path(project))
        expect(flash[:alert]).to eq("Failed to add comment.")
      end
    end
  end
end
