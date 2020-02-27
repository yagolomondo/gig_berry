class ConcertHallPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end





  def create?
    return true
  end


  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
