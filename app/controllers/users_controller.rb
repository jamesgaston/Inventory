class UsersController < ApplicationController
	

  def new
      before_user_edit
		@user = User.new
  end

  def edit
     before_user_edit
     @user = User.find(params[:id])
 end

  def destroy
  	@user = User.find_by_id( params[:id] )
  	items = Item.find_by_user_id(@user.id) 
  	for i in items 
  		i.destroy 
  	end
  		
	@user.destroy
	flash[:notice] = "User #{@user.email} was successfully deleted."
	redirect_to( :controller => 'users', :action => 'index' )
  end

  def show
  end

  def index
  	@users = User.order("email ASC")
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
         before_user_edit 
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
         before_user_edit
			flash.now[:error] = "User could not be updated."
			render :action => 'edit'
		end	
  	else
		redirect_to( :controller => 'items', :action => 'index' )
	end
 end






  def useradmin
  		if admin(@current_user) == false 
 		  redirect_to home_url 		
  		end
  end


	protected
	
		  # 	
		  # @context may contain info to guide whether menus are live 
	     # clear out the context variable before each method call
	     # if the method has some important context info, it will be set there
	     # alternatively we could set it to some default value 
	      

		  # call this before any new item or edit item call
		  # as we need to populate the lookup tables and set the context  
	def before_user_edit
	   @provinces = Province.ordered 
   end



end
