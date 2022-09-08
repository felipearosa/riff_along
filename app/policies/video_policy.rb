class VideoPolicy < ApplicationPolicy
  def update?
    record.users[0] == user
  end

  def destroy?
    record.users[0] == user
  end

  def show?
    true
  end

  def index?
    true
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
