# frozen_string_literal: true

class BusinessesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @businesses = if params[:salon_city]
                           pagy(Business.active.where(city_id: params[:salon_city]).order(created_at: :desc))
                         elsif params[:search]
                           pagy(Business.active.search(search_params).order(created_at: :desc))
                         else
                           pagy(Business.active.order(created_at: :desc))
                         end
  end

  def show
    @business = Business.active.find(params[:id])
    @treatments = @business.treatments.order(created_at: :desc)
    impressionist(@business)
  end

  private

  def search_params
    params.require(:search).permit(:name, :city_name)
  end
end
