class HomeController < ApplicationController

	def index
	end
	
	def video
	  render 'video', :layout => 'basic'
  end
	  
end
