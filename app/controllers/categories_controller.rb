class CategoriesController < ApplicationController
 

  def show
  end

  def edit
 	 @category = Category.find_by_id( params[:id] )
 	 render :layout => 'form'
  end

  def new
  	@category = Category.new 
  	render :layout => 'form'
  end

  def create
	  if !params[:category].include?( 'Cancel' )
		@category = Category.new(params[:category])
		if @category.save
			 flash[:notice] = "Category #{@category.name} was successfully created."
		 	redirect_to( :controller => 'categories', :action => 'index' )
		else

			flash.now[:error] = "Category could not be created."
			render :layout => 'form', :action => 'new' 
		end
	  else
	     redirect_to( :controller => 'categories', :action => 'index' )
	  end		  
  end

  def update
	  if !params[:category].include?( 'Cancel' )
			@category = Category.find_by_id(params[:id])
			if @category.update_attributes(params[:category])
				flash[:notice] = "Category #{@category.name} was successfully updated."
		 		redirect_to( :controller => 'categories', :action => 'index' )
			else
  				flash.now[:error] = "Category could not be updated."
  				render :layout => 'form',  :action => 'edit'
			end	
	  else
	     redirect_to( :controller => 'items', :action => 'index' )
	  end		
  
  
  end

  def delete
  end

  def index
  	@categories = Category.order("name") 
  end

end
