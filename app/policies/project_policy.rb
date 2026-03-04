# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    def resolve
      return scope.none unless user

      if user.admin?
        scope.all
      else
        # For nonadmins, you might want to show nothing, or only public projects.
        # Since you only want admins to have access, return an empty scope.
        scope.none
      end
    end
  end

  def show?
    # Allow anyone to view a project?
    # If you want even nonadmins to see project details, return true.
    # Otherwise, restrict to admins.
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def index?
    user.admin?
  end
end
