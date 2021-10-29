# frozen_string_literal: true

class BusinessesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @businesses = pagy(Business.order(created_at: :desc))
  end

  def show
    @business = Business.find(params[:id])
  end
end
