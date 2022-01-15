# frozen_string_literal: true

class BusinessPolicy < ApplicationPolicy
  attr_reader :user, :business

  def initialize(user, business)
    @user = user
    @business = business
  end

  def edit
    @user.id == @business.user_id
  end

  def update
    edit?
  end

  def show
    # byebug
    @user.id == @business.user_id
  end
end
