class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index
    record.user == user || record.concert_hall.user == user
  end

  def show
    record.user == user || record.concert_hall.user == user
  end

  def new?
  	record.concert_hall.user != user
  end

  def create?
  	new?
  end

  # def destroy?
  #   record.user == user || record.concert_hall.user == user
  # end

end
