# frozen_string_literal: true

module Dashboard
  class AppointmentsController < Dashboard::DashboardController
    before_action :set_appointment, only: %i[show edit update destroy]

    def index
      @appointments = current_user.appointments.all
      @upcoming_appointments = current_user.upcoming_appointments
    end

    def show
    end

    def new
      @appointment = Appointment.new
      @appointment.user_id = current_user.id
    end

    def edit
    end

    def create
      @appointment = Appointment.new(appointment_params)
      @appointment.user_id = current_user.id
      if @appointment.save
        redirect_to dashboard_appointment_path(@appointment), notice: 'Appointment was successfully created.'
      else
        render :new
      end
    end

    def update
      if @appointment.update(appointment_params)
        redirect_to dashboard_appointment_path(@appointment), notice: 'Appointment was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @appointment.destroy
      redirect_to dashboard_appointments_path, notice: 'Appointment was successfully destroyed.'
    end

    private

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:title, :client_name, :client_email, :start_time, :treatment_id)
    end
  end
end