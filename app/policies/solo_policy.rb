class SoloPolicy < ApplicationPolicy
  def update?
    record.video.users[0] == user
  end

  def destroy?
    record.video.users[0] == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
