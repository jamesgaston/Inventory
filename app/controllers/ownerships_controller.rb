class OwnershipsController < ApplicationController


  def edit
 	 @ownership = Ownership.find_by_id( params[:id] )
	render :layout => 'form'
  end

  def new
  	@ownership = Ownership.new 
  	render :layout => 'form'
  end

  def create
	  if !params[:ownership].include?( 'Cancel' )
		@ownership = Ownership.new(params[:ownership])
		if @ownership.save
			 flash[:notice] = "Ownership #{@ownership.name} was successfully created."
		 	redirect_to( :controller => 'ownerships', :action => 'index' )
		else

			flash.now[:error] = "Ownership could not be created."
			render :layout => 'form',  :action => 'new' 
		end
	  else
	     redirect_to( :controller => 'ownerships', :action => 'index' )
	  end		  
  end

  def update
	  if !params[:ownership].include?( 'Cancel' )
			@ownership = Ownership.find_by_id(params[:id])
			if @ownership.update_attributes(params[:ownership])
				flash[:notice] = "Ownership #{@ownership.name} was successfully updated."
		 		redirect_to( :controller => 'ownerships', :action => 'index' )
			else
  				flash.now[:error] = "Ownership could not be updated."
  				render :layout => 'form', :action => 'edit'
			end	
	  else
	     redirect_to( :controller => 'items', :action => 'index' )
	  end		
  
  
  end

  def destroy
  end

  def show
  end

 def index
    @ownerships = Ownership.order("id") 
  end


end
