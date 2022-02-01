# frozen_string_literal: true

module Dashboard
  class PagesController < Dashboard::DashboardController
    def home
      authorize :dashboard, :home?
      @businesses = current_user.businesses.active
      @treatments_count = @businesses.joins(:treatments).count
      @views_count = @businesses.reduce(0) do |sum, business|
        sum + business.impressionist_count(filter: :ip_address)
      end
    end
  end
end
