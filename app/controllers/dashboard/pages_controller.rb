# frozen_string_literal: true

module Dashboard
  class PagesController < Dashboard::DashboardController
    def home
      authorize :dashboard, :home?
      @businesses = current_user.businesses.active
      @treatments_count = @businesses.joins(:treatments).count
    end
  end
end
