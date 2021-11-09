# frozen_string_literal: true

class BusinessesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @businesses = if params[:salon_city]
                           pagy(Business.where(city: params[:salon_city]).order(created_at: :desc))
                         else
                           pagy(Business.order(created_at: :desc))
                         end
  end

  def show
    @business = Business.find(params[:id])
  end
end
