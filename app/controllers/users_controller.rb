class UsersController < ApplicationController
  def new
	@user = User.new
  end

  def edit
  end

  def destroy
  end

  def show
  end

  def index
  end
  
# create a new user after checking that the user didn't press the cancel button
  def create
  if !params[:user].include?( 'Cancel' )
		@user = User.new(params[:user])
		if @user.save
			sign_in @user 
			flash[:notice] = "User #{@user.email} was successfully created."
			redirect_to( :controller => 'pages', :action => 'home' )
		else
			flash.now[:error] = "User could not be created."
			render :action => 'new'
		end
	else
		redirect_to( :controller => 'pages', :action => 'home' )
	end
  end

  def update
  end

end
