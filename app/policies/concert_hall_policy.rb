class ConcertHallPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    return true
  end

  def new?
    create?
  end

  def update?
    record.user == user
  end

  def edit?
   update?
  end

  def destroy?
    record.user == user
  end

end





