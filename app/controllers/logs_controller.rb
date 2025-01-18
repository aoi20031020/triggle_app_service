class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] #CSRFトークンの無効化

  def create
    log_params = params.require(:log).permit(:message, :level, :timestamp)
    log = Log.new(log_params)

    if log.save
      render json: { status: 'success', log: log }, status: :created
    else
      render json: { status: 'error', message: 'Failed to save log' }, status: :unprocessable_entity
    end
  end
end
