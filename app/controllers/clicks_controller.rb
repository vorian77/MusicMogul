class ClicksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  def create
    current_user.clicks.create(entry_id: params[:entry_id], object: params[:object])
    render nothing: true
  end
end