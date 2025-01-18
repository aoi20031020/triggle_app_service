class CreateLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :logs do |t|
      t.string :message
      t.string :level
      t.datetime :timestamp

      t.timestamps
    end
  end
end
