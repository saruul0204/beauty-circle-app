# frozen_string_literal: true

module Dashboard
  class BusinessesController < Dashboard::DashboardController
    before_action :find_business, only: %i[show edit update destroy]

    def index
      @businesses = current_user.businesses.active
    end

    def show
      @treatments = @business.treatments.order(created_at: :desc)
    end

    def new
      @business = Business.new
      @business.treatments.new
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
      @business.update!(deleted_at: Time.zone.now)
      flash[:notice] = "You have deleted #{@business.name.to_s.capitalize} business."
      redirect_to dashboard_businesses_path
    end

    private

    def business_params
      params.require(:business).permit(:name, :description, :address, :city_id, :country, :open_hour,
                                       :close_hour, :phone_number, :email, :facebook_url, :instagram_url,
                                       treatments_attributes: %i[id name description price duration _destroy])
    end

    def find_business
      @business = current_user.businesses.active.find(params[:id])
    end
  end
end
