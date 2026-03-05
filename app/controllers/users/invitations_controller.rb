# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    # Only allow admins to send invitations
    before_action :authorize_admin, only: %i[new create]

    def new
      super
    end

    # Override the create action to assign default role
    def create
      self.resource = invite_resource
      if resource.errors.empty?
        set_flash_message :notice, :send_instructions, email: resource.email
        respond_with resource, location: after_invite_path_for(resource)
      else
        respond_with_navigational(resource) { render :new, status: :unprocessable_entity }
      end
    end

    protected

    def invite_resource
      # Set default role for invited users (e.g., :viewer)
      User.invite!(invite_params.merge(role: :viewer), current_user)
    end

    def authorize_admin
      return if current_user&.admin?

      flash[:alert] = 'Only admins can send invitations'
      redirect_to root_path
    end
  end
end
