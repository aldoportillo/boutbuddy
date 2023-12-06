class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user&.admin?
        @scope.all
      elsif @user&.role == "promoter"
        @user&.own_events
      else
        @scope.where("time > ?", Time.now)
      end
    end
  end

  def create?
    @user&.admin? || @user&.role == "promoter"
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  # You may need to define the initialize method if it's not in ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end
end
