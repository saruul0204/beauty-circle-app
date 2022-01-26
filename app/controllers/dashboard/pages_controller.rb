# frozen_string_literal: true

module Dashboard
  class PagesController < Dashboard::DashboardController
    def home
      authorize :dashboard, :home?
    end
  end
end
