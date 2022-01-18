# frozen_string_literal: true

class BusinessPolicy < ApplicationPolicy
  def show?
    @user == @record.user
  end

  def new?
    create?
  end

  def create?
    @user == @record.user
  end

  def update?
    @user == @record.user
  end

  def edit?
    update?
  end

  def destroy?
    @user == @record.user
  end
end
