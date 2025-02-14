require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "assigns @projects" do
      get :index
      expect(assigns(:projects)).to eq([project]) # Make sure the project is assigned correctly
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "assigns a new Project to @project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new project" do
        expect {
          post :create, params: { project: { name: "Test Project", status: "open", description: "Test description" } }
        }.to change(Project, :count).by(1)
      end

      it "redirects to the projects path with a success message" do
        post :create, params: { project: { name: "Test Project", status: "open", description: "Test description" } }
        expect(response).to redirect_to(projects_path)
        expect(flash[:notice]).to eq("Project created successfully")
      end
    end

    context "with invalid parameters" do
      it "does not create a project" do
        expect {
          post :create, params: { project: { name: "", status: "", description: "" } }
        }.to_not change(Project, :count)
      end

      it "renders the :new template with an unprocessable entity status" do
        post :create, params: { project: { name: "", status: "", description: "" } }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested project to @project" do
      get :show, params: { id: project.id }
      expect(assigns(:project)).to eq(project)
    end

    it "renders the :show template" do
      get :show, params: { id: project.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    it "assigns the requested project to @project" do
      get :edit, params: { id: project.id }
      expect(assigns(:project)).to eq(project)
    end

    it "renders the :edit template" do
      get :edit, params: { id: project.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested project" do
        patch :update, params: { id: project.id, project: { name: "Updated Project", status: "closed", description: "Updated description" } }
        project.reload
        expect(project.name).to eq("Updated Project")
        expect(project.status).to eq("closed")
      end

      it "redirects to the projects path with a success message" do
        patch :update, params: { id: project.id, project: { name: "Updated Project", status: "closed", description: "Updated description" } }
        expect(response).to redirect_to(projects_path)
        expect(flash[:notice]).to eq("Project updated successfully")
      end
    end

    context "with invalid parameters" do
      it "does not update the project" do
        patch :update, params: { id: project.id, project: { name: "", status: "", description: "" } }
        project.reload
        expect(project.name).to_not eq("")
      end

      it "renders the :edit template with an unprocessable entity status" do
        patch :update, params: { id: project.id, project: { name: "", status: "", description: "" } }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the project" do
      project = create(:project, user: user)
      expect {
        delete :destroy, params: { id: project.id }
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects path with a success message" do
      delete :destroy, params: { id: project.id }
      expect(response).to redirect_to(projects_path)
      expect(flash[:notice]).to eq("Project deleted successfully!")
    end
  end
end
