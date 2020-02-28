class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
  	record.concert_hall.user != user
  end

  def create?
  	new?
  end
end
