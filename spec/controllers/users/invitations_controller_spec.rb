require 'rails_helper'

RSpec.describe Users::InvitationsController, type: :request do
  describe 'GET /users/invitation/new' do
    context 'as admin' do
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }

      it 'returns http success' do
        get new_user_invitation_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'as viewer' do
      let(:viewer) { create(:user, :viewer) }
      before { sign_in viewer }

      it 'redirects with alert' do
        get new_user_invitation_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('Only admins can send invitations')
      end
    end

    context 'without authentication' do
      it 'redirects to sign in' do
        get new_user_invitation_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /users/invitation' do
    let(:invite_params) { { email: 'newuser@example.com' } }

    context 'as admin' do
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }

      it 'creates an invitation with default role viewer' do
        expect {
          post user_invitation_path, params: { user: invite_params }
        }.to change(User, :count).by(1)
        new_user = User.last
        expect(new_user.email).to eq('newuser@example.com')
        expect(new_user.role).to eq('viewer')
        expect(new_user.invited_by).to eq(admin)
      end

      it 'redirects with notice' do
        post user_invitation_path, params: { user: invite_params }
        expect(response).to redirect_to(root_path) # or after_invite_path
        follow_redirect!
        expect(response.body).to include('An invitation email has been sent')
      end

      context 'with invalid email' do
        it 'renders new with errors' do
          post user_invitation_path, params: { user: { email: '' } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:new)
        end
      end
    end

    context 'as viewer' do
      let(:viewer) { create(:user, :viewer) }
      before { sign_in viewer }

      it 'redirects with alert and does not invite' do
        expect {
          post user_invitation_path, params: { user: invite_params }
        }.not_to change(User, :count)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end