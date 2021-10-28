# frozen_string_literal: true

class BusinessesController < ApplicationController
  def index
    Business.all
  end

  def show
    @business = Business.find(params[:id])
  end
end
