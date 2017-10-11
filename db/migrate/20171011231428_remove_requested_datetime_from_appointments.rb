class RemoveRequestedDatetimeFromAppointments < ActiveRecord::Migration[5.1]
  def change
    remove_column :appointments, :requested_datetime, :datetime
  end
end
