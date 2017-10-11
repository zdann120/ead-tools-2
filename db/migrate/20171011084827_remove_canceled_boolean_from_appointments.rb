class RemoveCanceledBooleanFromAppointments < ActiveRecord::Migration[5.1]
  def change
    remove_column :appointments, :canceled, :boolean
  end
end
