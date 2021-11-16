# frozen_string_literal: true

module Dashboard
  class TreatmentsController < Dashboard::DashboardController
    def create
      @treatment = Treatment.new(treatment_params)

      if @treatment.save
        flash[:notice] = 'You have successfully added the treatment'
      else
        flash[:alert] = 'Treatment is not saved, Please try again'
      end

      redirect_to @treatment.business
    end

    def treatment_params
      params.require(:treatment).permit(:name, :description, :price, :duration, :business_id)
    end
  end
end
