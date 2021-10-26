# frozen_string_literal: true

class BusinessesController < ApplicationController
  def index
    if params[:salon_city]
      @businesses = Business.where(city: params[:salon_city])
    else
      @businesses = Business.all
    end
  end

  def show
    @business = Business.find(params[:id])
  end
end
