class PagesController < ApplicationController
  
  # GET /pages/:name
  # GET /pages/more_info
  # GET /pages/more_info_fans
  def show
    if params[:name] == 'notices'
      @ayah = ayah
      @contact = Contact.new
    end
    render(params[:name])
  end

  def sponsors
    # Eventually load sponsors from database
  end
end
