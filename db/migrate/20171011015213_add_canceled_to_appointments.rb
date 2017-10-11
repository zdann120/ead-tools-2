class AddCanceledToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :canceled, :boolean, default: false
  end
end
