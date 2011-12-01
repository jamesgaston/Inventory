class ItemsController < ApplicationController
	before_filter :get_lookups, :only => [:new, :edit, :update, :create] 
   include ItemsHelper
   
   
  def new
   @user = current_user
	@item = Item.new(:number => 1) 
	@item.user_id = @user.id
	render :layout => 'form'
  end

  def edit
   @item = Item.find_by_id( params[:id] )

		# Ugly: the rest is 'cause I want to indicate the owner assuming we are admin mode ... 
	item_owner = User.find_by_id( @item.user_id )
	if( item_owner != current_user )
		@item_owner = item_owner.email
	else
		@item_owner = "" 		
	end  
	render :layout => 'form'
  end

  def destroy
	@item = Item.find_by_id( params[:id] )
	@item.destroy
	flash[:notice] = "Item #{@item.name} was successfully deleted."
	redirect_to( :controller => 'items', :action => 'index' )
  end


  def show
   ## @current_user = current_user  
   @item = Item.find_by_id( params[:id] )
 	@item_ownership = @item.ownership_id.nil? ?  "" :  Ownership.find_by_id(@item.ownership_id).name
	@item_category = @item.category_id.nil? ? "" : Category.find_by_id(@item.category_id).name
	find_samename_items(@item) 
  end

  def index
   user = current_user
   if signed_in_as_admin
		@items = Item.order('Name')
		@show_owner = true
  else
	   @show_owner = false
		@items = Item.where("user_id = ?", user.id).order('Name')
	end  
  end

  def create
	  if !params[:item].include?( 'Cancel' )
		@item = Item.new(params[:item])
		if @item.save
			 flash[:notice] = "Item #{@item.name} was successfully created."
		 	redirect_to( :controller => 'items', :action => 'index' )
		else
			flash.now[:error] = "Item could not be created."
			render :layout => 'form', :action => 'new' 
		end
	  else
	     redirect_to( :controller => 'items', :action => 'index' )
	  end		
  end

  def update
 	  @item = Item.find_by_id(params[:id])
	  if !params[:item].include?( 'Cancel' )
			
			if @item.update_attributes(params[:item])
				flash[:notice] = "Item #{@item.name} was successfully updated."
		 		redirect_to( :controller => 'items', :action => 'show', :id => @item.id )
			else
				flash.now[:error] = "Item could not be updated."
				render :layout => 'form', :action => 'edit'
			end	
	  else
	     redirect_to( :controller => 'items', :action => 'show', :id => @item.id )
	  end		
  end

	private

		  # populate the lookup tables  
	def get_lookups
	   @categories = Category.ordered 
		@ownerships = Ownership.ordered
  end


end
