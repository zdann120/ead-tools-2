class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.references :user, foreign_key: true
      t.string :token
      t.datetime :requested_datetime, null: false
      t.text :comments, null: true
      t.boolean :approved, default: false

      t.timestamps
    end
    add_index :appointments, :token, unique: true
  end
end
