module Api
  class ResultsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create] #CSRFトークンの無効化

    # GET /api/result
    def show
      game_result = Result.last

      if game_result
        render json: game_result, status: :ok
      else
        render json: { status: 'error', message: 'No game result found' }, status: :not_found
      end
    end

    # POST /api/result
    def create
      game_result_params = params.require(:game_result).permit(
        :timestamp,
        :player_number,
        final_scores: [],  # final_scoresは配列なので、単純に配列として許可
        game_record: [
          :player_number,
          {click_pole: [], clicked_pole: []},
          :player1,
          :player2,
          :player3,
          :player4
        ]
      )

      # ゲーム結果を作成して保存
      game_result = Result.new(game_result_params)

      if game_result.save
        render json: { status: 'success', game_result: game_result }, status: :created
      else
        render json: { status: 'error', message: 'Failed to save game result', errors: game_result.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
