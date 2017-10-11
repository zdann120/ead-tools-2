class AddRequestedDateAndTimeToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :requested_date, :date
    add_column :appointments, :requested_time, :time
  end
end
