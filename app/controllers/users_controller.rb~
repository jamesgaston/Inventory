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

  def create
	@user = User.new(params[:user])
	if @user.save
		flash[:notice] = "User #{@user.email} was successfully created."
		redirect_to( :controller => 'pages', :action => 'home' )
	else
		flash.now[:error] = "User could not be created."
		render :action => 'new'
	end
  end

  def update
  end

end
