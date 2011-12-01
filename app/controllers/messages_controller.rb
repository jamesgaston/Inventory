class MessagesController < ApplicationController
 include UsersHelper
 include ItemsHelper

  def new
  
    ## currently this is not called ...

   @user = current_user
	@message = Message.new( :sender_id => params[:sender_id],:recipient_id => params[:recipient_id],
	       :show_email => false, :item_id => params[:item_id] ) 
	render :layout => 'form'
  end

  def create
	  if !params[:message].include?( 'Cancel' )
		@message = Message.new(params[:message])
		if @message.save
			 flash[:notice] = "Message sent."
			 
		    redirect_to( :controller => 'items', :action => 'index' )
		else
			flash.now[:error] = "Message could not be sent."
			render :layout => 'form', :action => 'new' 
		end
	  else
	     redirect_to( :controller => 'items', :action => 'index' )
	  end		  
  
  end

  def edit
  end

  def update
  end

  def index
   user = current_user
 	@messages_received = Message.where("recipient_id = ?", user.id).order('created_at ASC')
 	@messages_sent = Message.where("sender_id = ?", user.id).order('created_at ASC')
  end

  def destroy
  	@message = Message.find_by_id( params[:id] )
	@message.destroy
	flash[:notice] = "Message deleted."
	redirect_to( :controller => 'messages', :action => 'index' )
  end

end
