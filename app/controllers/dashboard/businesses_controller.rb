# frozen_string_literal: true

module Dashboard
  class BusinessesController < Dashboard::DashboardController
    before_action :find_business, only: %i[show edit update destroy]

    def index
      @businesses = current_user.businesses
    end

    def show; end

    def new
      @business = Business.new
    end

    def create
      @business = Business.new(business_params)
      @business.user_id = current_user.id

      if @business.save
        redirect_to @business
      else
        render :new
      end
    end

    def edit; end

    def update
      if @business.update(business_params)
        redirect_to @business
      else
        render :edit
      end
    end

    def destroy
      @business.destroy

      redirect_to businesses_path
    end

    private

    def business_params
      params.require(:business).permit(:name, :description, :address, :city, :country, :open_hour,
                                       :close_hour, :phone_number, :email)
    end

    def find_business
      @business = current_user.businesses.find(params[:id])
    end
  end
end
