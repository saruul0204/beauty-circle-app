# frozen_string_literal: true

class BusinessesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @businesses = if params[:salon_city]
                           pagy(Business.where(city_id: params[:salon_city]).order(created_at: :desc))
                         else
                           pagy(Business.order(created_at: :desc))
                         end
    @businesses = Business.search(params[:q]) if params[:q]
  end

  def show
    @business = Business.find(params[:id])
    @treatments = @business.treatments.all.order(created_at: :desc)
  end
end
