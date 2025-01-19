class Result < ApplicationRecord
  validates :timestamp, :player_number, :final_scores, :game_record, presence: true
end
