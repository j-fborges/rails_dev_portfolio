# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      projects_path
    else
      root_path # nonadmins stay on the home page
    end
  end
end
