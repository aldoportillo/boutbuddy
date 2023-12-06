class VenuePolicy < ApplicationPolicy
  attr_reader :user, :venue

  def initialize(user, venue)
    @user = user
    @venue = venue
  end

  def show?
    user&.admin? || user&.role == "promoter"
  end

  def create?
    new?
  end

  def new?
    user&.admin? || user&.role == "promoter"
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user&.admin?
        @scope.all
      elsif @user&.role == "promoter"
        @user&.own_venues
      else
        @scope.none
      end
    end
  end
end
