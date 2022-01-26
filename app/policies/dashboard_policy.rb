# frozen_string_literal: true

DashboardPolicy = Struct.new(:user, :dashboard) do
  def home?
    user.present?
  end
end
