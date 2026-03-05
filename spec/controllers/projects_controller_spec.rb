require 'rails_helper'

RSpec.describe ProjectsController, type: :request do
  let(:admin) { create(:user, :admin) }
  let(:viewer) { create(:user, :viewer) }
  let(:project) { create(:project) }

  describe 'GET #index' do
    context 'as admin' do
      before { sign_in admin }

      it 'returns http success' do
        get projects_path
        expect(response).to have_http_status(:success)
      end

      it 'assigns all projects' do
        project1 = create(:project)
        project2 = create(:project)
        get projects_path
        expect(assigns(:projects)).to match_array([project1, project2])
      end

      it 'uses policy_scope' do
        expect_any_instance_of(ProjectPolicy::Scope).to receive(:resolve).and_call_original
        get projects_path
      end
    end

    context 'as viewer' do
      before { sign_in viewer }

      it 'redirects with unauthorized' do
        get projects_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('not authorized')
      end
    end

    context 'without authentication' do
      it 'redirects to sign in' do
        get projects_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    context 'as admin' do
      before { sign_in admin }

      it 'returns http success' do
        get project_path(project)
        expect(response).to have_http_status(:success)
      end
    end

    context 'as viewer' do
      before { sign_in viewer }

      it 'redirects with unauthorized' do
        get project_path(project)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #new' do
    context 'as admin' do
      before { sign_in admin }

      it 'returns http success' do
        get new_project_path
        expect(response).to have_http_status(:success)
      end

      it 'assigns a new project' do
        get new_project_path
        expect(assigns(:project)).to be_a_new(Project)
      end

      it 'sets default mode to file' do
        get new_project_path
        expect(assigns(:mode)).to eq('file')
      end
    end

    context 'as viewer' do
      before { sign_in viewer }

      it 'redirects with unauthorized' do
        get new_project_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'as admin' do
      before { sign_in admin }

      it 'returns http success' do
        get edit_project_path(project)
        expect(response).to have_http_status(:success)
      end

      it 'sets mode to file' do
        get edit_project_path(project)
        expect(assigns(:mode)).to eq('file')
      end
    end

    context 'as viewer' do
      before { sign_in viewer }

      it 'redirects with unauthorized' do
        get edit_project_path(project)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      { title: 'New Project', date: Date.today, website_url: 'http://example.com' }
    end

    context 'as admin' do
      before { sign_in admin }

      context 'with valid params' do
        it 'creates a new project' do
          expect {
            post projects_path, params: { project: valid_attributes }
          }.to change(Project, :count).by(1)
        end

        it 'redirects to the created project' do
          post projects_path, params: { project: valid_attributes }
          expect(response).to redirect_to(Project.last)
        end

        it 'responds with JSON' do
          post projects_path, params: { project: valid_attributes }, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'with invalid params' do
        it 'does not create a project' do
          expect {
            post projects_path, params: { project: { title: '' } }
          }.not_to change(Project, :count)
        end

        it 'renders new template' do
          post projects_path, params: { project: { title: '' } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:new)
        end

        it 'responds with JSON errors' do
          post projects_path, params: { project: { title: '' } }, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json')
          expect(JSON.parse(response.body)).to have_key('title')
        end
      end
    end

    context 'as viewer' do
      before { sign_in viewer }

      it 'redirects with unauthorized' do
        post projects_path, params: { project: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:project) { create(:project, title: 'Old Title') }
    let(:new_attributes) { { title: 'New Title' } }

    context 'as admin' do
      before { sign_in admin }

      context 'with valid params' do
        it 'updates the project' do
          patch project_path(project), params: { project: new_attributes }
          project.reload
          expect(project.title).to eq('New Title')
        end

        it 'redirects to the project' do
          patch project_path(project), params: { project: new_attributes }
          expect(response).to redirect_to(project)
        end

        it 'responds with JSON' do
          patch project_path(project), params: { project: new_attributes }, as: :json
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'with invalid params' do
        it 'renders edit' do
          patch project_path(project), params: { project: { title: '' } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:edit)
        end

        it 'responds with JSON errors' do
          patch project_path(project), params: { project: { title: '' } }, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to have_key('title')
        end
      end
    end

    context 'as viewer' do
      before { sign_in viewer }

      it 'redirects with unauthorized' do
        patch project_path(project), params: { project: new_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:project) { create(:project) }

    context 'as admin' do
      before { sign_in admin }

      it 'destroys the project' do
        expect {
          delete project_path(project)
        }.to change(Project, :count).by(-1)
      end

      it 'redirects to projects list' do
        delete project_path(project)
        expect(response).to redirect_to(projects_path)
      end

      it 'responds with JSON no content' do
        delete project_path(project), as: :json
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'as viewer' do
      before { sign_in viewer }

      it 'does not destroy the project' do
        expect {
          delete project_path(project)
        }.not_to change(Project, :count)
      end

      it 'redirects with unauthorized' do
        delete project_path(project)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end