class SessionsController < ApplicationController
  def new
  end

  def create
	user = User.authenticate(params[:session][:email], 
				params[:session][:password])
	if user.nil?
		flash.now[:error] = "Sorry, login information incorrect."
		render :action => "new"
	else
		flash[:notice] = "User #{user.email} successfully logged in."
		redirect_to( :controller => 'items', :action => 'index' )
	end
  end

  def destroy
  end

end
