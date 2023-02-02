# frozen_string_literal: true

class AppointmentsController < InheritedResources::Base
  private

  def appointment_params
    params.require(:appointment).permit(:title, :client_name, :client_email, :start_time, :treatment_id, :user_id)
  end
end
