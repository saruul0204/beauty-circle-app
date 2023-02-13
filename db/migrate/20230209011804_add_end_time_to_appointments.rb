class AddEndTimeToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :end_time, :datetime
  end
end
