class ItemsController < ApplicationController

  def new
	@item = Item.new
  end

  def edit
	@item = Item.find_by_id( params[:id] )
  end

  def destroy
	@item = Item.find_by_id( params[:id] )
	@item.destroy
	flash[:notice] = "Item #{@item.name} was successfully deleted."
	 redirect_to( :controller => 'items', :action => 'index' )
  end

 def remove
	@item = Item.find_by_id( params[:id] )
	@item.destroy
	flash[:notice] = "Item #{@item.name} was successfully deleted."
	 redirect_to( :controller => 'items', :action => 'index' )
  end
  


  def show
  end

  def index
	@items = Item.all
  end

  def create
	@item = Item.new(params[:item])
	if @item.save
		 flash[:notice] = "Item #{@item.name} was successfully created."
		 redirect_to( :controller => 'items', :action => 'index' )
	else
		flash.now[:error] = "Item could not be created."
		render :action => 'new'
	end	
  end

  def update
	@item = Item.find_by_id(params[:id])
	if @item.update_attributes(params[:item])
		flash[:notice] = "Item #{@item.name} was successfully updated."
		 redirect_to( :controller => 'items', :action => 'index' )
	else
		flash.now[:error] = "Item could not be updated."
		render :action => 'edit'
	end	

  end

end
