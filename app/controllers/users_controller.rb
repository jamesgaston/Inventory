class UsersController < ApplicationController
  def new
		@user = User.new
  end

  def edit
	  @user = User.find(params[:id])
  end

  def destroy
  end

  def show
  end

  def index
  end

    # method  create   	
    # create a new user  
  def create
    					# check that the user didn't press the cancel button
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


	# method update
	# update the user's info unless they pressed the cancel button   
  def update
   if !params[:user].include?( 'Cancel' )
		@user = User.find_by_id(params[:id])
		if @user.update_attributes(params[:user])
			flash[:notice] = "User #{@user.email} was successfully updated."
		 	redirect_to( :controller => 'items', :action => 'index' )
		else
			flash.now[:error] = "User could not be updated."
			render :action => 'edit'
		end	
  	else
		redirect_to( :controller => 'pages', :action => 'home' )
	end
 end


end
