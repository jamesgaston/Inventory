class UsersController < ApplicationController
	before_filter :get_lookups, :only => [:new, :edit, :update, :create] 
	

  def new
    	@user = User.new
		render :layout => 'form'
  end

  def edit
      @user = User.find_by_id(params[:id])
		render :layout => 'form'
 end

  def destroy
  	@user = User.find_by_id( params[:id] )
  	items = Item.find_all_by_user_id(@user.id) 
	items.each {|x| x.destroy }	
	@user.destroy
	flash[:notice] = "User #{@user.email} deleted."
	redirect_to( :controller => 'users', :action => 'index' )
  end

  def show
       @user = User.find_by_id(params[:id])
       if @user.province_id.nil?
       	@province = ""
       	@country = ""
     	 else
   	    p = Province.find_by_id(@user.province_id)
   	    @province = p.name  
   	    @country = Country.find_by_id(p.country_id).name
		end  
  end

  def index
  	@users = User.order("email ASC")
  end

     	
   
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
			render :layout => 'form',  :action => 'new'
		end
	else
		redirect_to( :controller => 'pages', :action => 'home' )
	end
  end

 
  def update
   if !params[:user].include?( 'Cancel' )
		@user = User.find_by_id(params[:id])
		if @user.update_attributes(params[:user])
			flash[:notice] = "User #{@user.email} was successfully updated."
		 	redirect_to( :controller => 'items', :action => 'index' )
		else
			flash.now[:error] = "User could not be updated."
			render :layout => 'form', :action => 'edit'
		end	
  	else
		redirect_to( :controller => 'items', :action => 'index' )
	end
 end

private
	
             # populate the lookup table
	def get_lookups
	   @provinces = Province.ordered 
   end

end
