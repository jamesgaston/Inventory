class ItemsController < ApplicationController

  def new
   @categories = Category.ordered 
	@ownerships = Ownership.ordered
	@item = Item.new 
   user = current_user
	@item.user_id = user.id
  end

  def edit
   @categories = Category.ordered 
	@ownerships = Ownership.ordered
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
   user = current_user
	@items = Item.where("user_id = ?", user.id).order('Name')
  end

  def create
	  if !params[:item].include?( 'Cancel' )
		@item = Item.new(params[:item])
		if @item.save
			 flash[:notice] = "Item #{@item.name} was successfully created."
		 	redirect_to( :controller => 'items', :action => 'index' )
		else
		       # if you redirect to controller => items, action=> new 
		       # you don't need to repeat the following 2 lines
		       # however you do lose the error messages associated with the new item
		       
		   @categories = Category.ordered 
      	@ownerships = Ownership.ordered
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
				flash.now[:error] = "Item could not be updated."
				render :action => 'edit'
			end	
	  else
	     redirect_to( :controller => 'items', :action => 'index' )
	  end		

  end

end
