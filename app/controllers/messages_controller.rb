class MessagesController < ApplicationController
 include UsersHelper
 include ItemsHelper

  def create
	  if !params[:message].include?( 'Cancel' )
			@message = Message.new(params[:message])
			if @message.save
				 flash[:notice] = "Message sent."
				 redirect_to :controller=>"items", :action => "show", :id => @message.my_item 
			else
				flash.now[:error] = "Message could not be sent."
				render :layout => 'form', :action => 'new' 
			end
	  else
	     redirect_to items_url           
	  end		  
  
  end

  def index
    @items = Item.find_all_by_user_id(current_user.id)
   end

  def destroy
  	@message = Message.find_by_id( params[:id] )
	@message.destroy
	flash[:notice] = "Message deleted."
	redirect_to messages_url         
  end

end
