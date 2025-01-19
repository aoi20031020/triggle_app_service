class CreateResults < ActiveRecord::Migration[8.0]
  def change
    create_table :results do |t|
      t.string :timestamp
      t.integer :player_number
      t.json :final_scores
      t.json :game_record

      t.timestamps
    end
  end
end
