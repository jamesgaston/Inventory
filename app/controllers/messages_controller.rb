class MessagesController < ApplicationController
 include UsersHelper
 include ItemsHelper

		# got rid of new(), edit(), and delete() methods
		# Maybe update routes so it doesn't generate them?

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

		# got rid of unused instance var
		# the item method makes getting messages easier --
		# and we don't need to know as much about how messages are implemented
		 
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
