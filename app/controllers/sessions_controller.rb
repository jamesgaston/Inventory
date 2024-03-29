class SessionsController < ApplicationController
  def new
  end

  def create
	user = User.authenticate(params[:session][:email], 
				params[:session][:password])
	if user.nil?
			# when rendering use flash.now else the message may last for two pages		
		flash.now[:error] = "Sorry, login information incorrect."
		render :action => "new"
	else
		sign_in user 
			# when redirecting use flash as it appears for one link request 
		flash[:notice] = "User #{user.email} successfully logged in."
		redirect_to( :controller => 'items', :action => 'index' )
	end
  end

  
# method destroy
#
def destroy
	sign_out   # in SessionsHelper 
	redirect_to root_path
end


end
