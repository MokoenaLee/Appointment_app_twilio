class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :name
      t.string :phone_number
      t.datetime :time

      t.timestamps
    end
  end
end
