class ItemsController < ApplicationController
	before_filter :get_lookups, :only => [:new, :edit, :update, :create]
   include ItemsHelper
   
   	# got rid of instance variable for user
   	# added two params to new method 
   	
  def new
	@item = Item.new(:number => 1, :user_id => current_user.id )
	render :layout => 'form' 
  end

		# got rid of extraneous current item variable 
		
  def edit
   @item = Item.find_by_id( params[:id] )
   render :layout => 'form'
  end

		# redirect to named route  
		
  def destroy
	@item = Item.find_by_id( params[:id] )
	@item.destroy
	flash[:notice] = "#{@item.name} was removed from your inventory."
	redirect_to items_url 
  end

		# got rid of extraneous current item variable 
		# renamed item method 

  def show
      @item = Item.find_by_id( params[:id] )
      @items_like_mine = @item.find_items_like_mine  
  end

		# got rid of extraneous current item variable 

  def index
		 @items = Item.find_my_items(current_user)   
  end

		# redirect to named route  (when possible) 

  def create
	  if !params[:item].include?( 'Cancel' )
		@item = Item.new(params[:item])
		if @item.save
			 flash[:notice] = "#{@item.name} was added to your inventory."
			 
			 	# why doesn't this work?
				#	 redirect_to( item_url, :id => @item.id )
				# error: No route matches {:action=>"show", :controller=>"items"} ???
				
		 	 redirect_to( :controller=>"items", :action =>"show", :id => @item.id ) 
		else
			flash.now[:error] = "Item could not be created."
			render :layout => 'form', :action => 'new' 
		end
	  else
	     redirect_to  items_url  
	  end		
  end

		# redirect to named route  

  def update
 	  @item = Item.find_by_id(params[:id])
	  if !params[:item].include?( 'Cancel' )
			
			if @item.update_attributes(params[:item])
				flash[:notice] = "#{@item.name} was updated."
			   redirect_to( item_url, :id => @item.id ) 
			else
				flash.now[:error] = "Item could not be updated."
				render :layout => 'form', :action => 'edit'
			end	
	  else
	     redirect_to( item_url, :id => @item.id ) 
 	  end		
  end



private
		  # populate the lookup tables  
	def get_lookups
	   @categories = Category.ordered 
		@ownerships = Ownership.ordered
  end


end
