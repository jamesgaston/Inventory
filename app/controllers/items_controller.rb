class ItemsController < ApplicationController
	before_filter :set_context 
 
   
  def new
   before_item_edit
   user = current_user
	@item = Item.new 
	@item.user_id = user.id
  end

  def edit
   before_item_edit
	@item = Item.find_by_id( params[:id] )
  end

  def destroy
	@item = Item.find_by_id( params[:id] )
	@item.destroy
	flash[:notice] = "Item #{@item.name} was successfully deleted."
	redirect_to( :controller => 'items', :action => 'index' )
  end


  def show
  end

  def index
   @context = "inventory"  
   user = current_user
   if admin(user) == true
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
 		   before_item_edit
			flash.now[:error] = "Item could not be created."
			render :action => 'new' 
		end
	  else
	     redirect_to( :controller => 'items', :action => 'index' )
	  end		
  end

  def update
	  if !params[:item].include?( 'Cancel' )
			@item = Item.find_by_id(params[:id])
			if @item.update_attributes(params[:item])
				flash[:notice] = "Item #{@item.name} was successfully updated."
		 		redirect_to( :controller => 'items', :action => 'index' )
			else
			   before_item_edit
				flash.now[:error] = "Item could not be updated."
				render :action => 'edit'
			end	
	  else
	     redirect_to( :controller => 'items', :action => 'index' )
	  end		
  end

	protected
	
		  # 	
		  # @context may contain info to guide whether menus are live 
	     # clear out the context variable before each method call
	     # if the method has some important context info, it will be set there
	     # alternatively we could set it to some default value 
	      
	def set_context
		@context = "" 
	end

		  # call this before any new item or edit item call
		  # as we need to populate the lookup tables and set the context  
	def before_item_edit
	   @categories = Category.ordered 
		@ownerships = Ownership.ordered
   	@context = "edit"
  end


end
