class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :user_id, null: false
      t.datetime :start_at, null:false
      t.datetime :finish_at, null:false
      t.string :location, null:false
      t.string :comment
      t.timestamps
    end
  end
end
