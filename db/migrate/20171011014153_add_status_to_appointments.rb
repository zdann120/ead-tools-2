class AddStatusToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :status, :integer
    remove_column :appointments, :approved, :boolean, default: false
  end
end
