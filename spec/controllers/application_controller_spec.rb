require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'after_sign_in_path_for' do
    it 'redirects admin to projects_path' do
      admin = create(:user, role: :admin)
      expect(controller.send(:after_sign_in_path_for, admin)).to eq(projects_path)
    end

    it 'redirects viewer to root_path' do
      viewer = create(:user, role: :viewer)
      expect(controller.send(:after_sign_in_path_for, viewer)).to eq(root_path)
    end
  end

  describe 'Pundit::NotAuthorizedError handling' do
    controller do
      def test_action
        raise Pundit::NotAuthorizedError
      end
    end

    before do
      routes.draw { get 'test_action' => 'anonymous#test_action' }
    end

    it 'redirects with alert' do
      viewer = create(:user, role: :viewer)
      sign_in viewer
      get :test_action
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You are not authorized to perform this action.')
    end
  end
end