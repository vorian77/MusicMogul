class ContractsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_contest_running!
  skip_before_filter :verify_authenticity_token

  def create
    current_user.contracts.create(entry_id: params[:entry_id])
    render nothing: true
  end
end