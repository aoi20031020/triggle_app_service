class CreateGameResults < ActiveRecord::Migration[8.0]
  def change
    create_table :game_results do |t|
      t.datetime :timestamp
      t.integer :player_number
      t.json :final_scores
      t.json :game_record

      t.timestamps
    end
  end
end
