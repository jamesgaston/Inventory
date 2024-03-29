require 'test_helper'

class MessageTest < ActiveSupport::TestCase

		# test that validations for non-empty messages work 
   test "message empty so not valid " do
     message = Message.new
     assert !message.valid?   	
   end
 

		# test that a new message with all fields populated is valid 
   test "message has all components so valid" do
      message = Message.new
     
   	message.buyer_item_id = 1
		message.buyer_user_id = 1
		message.seller_item_id = 2
		message.seller_user_id = 2
		message.sender_user_id = 1 
		message.message_text = "A message"      
 
      assert message.valid?  	
   end




end
